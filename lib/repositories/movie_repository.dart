import 'package:logger/logger.dart';
import '../models/tmdb_models.dart';
import '../services/tmdb_api_client.dart';
import '../database/app_database.dart';
import '../database/entities.dart';

class MovieRepository {
  final TMDbApiClient apiClient;
  final AppDatabase database;
  final Logger logger = Logger();

  final String apiKey = '5a7e56f93cdbd18eabee7b3cd27eb06e';
  static const int CACHE_DURATION_HOURS = 24;

  MovieRepository({
    required this.apiClient,
    required this.database,
  });

  Future<List<Movie>> getUpcomingMovies({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedMovies = await database.movieDao.getAllMovies();
        if (cachedMovies.isNotEmpty) {
          return cachedMovies.map(_entityToMovie).toList();
        }
      }

      final response = await apiClient.getUpcomingMovies(apiKey, page);

      final entities = response.movies.map((movie) {
        return MovieEntity(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
          releaseDate: movie.releaseDate,
          rating: movie.rating,
          genreIds: movie.genreIds?.join(','),
          cachedAtMillis: DateTime.now().millisecondsSinceEpoch,
        );
      }).toList();

      await database.movieDao.insertMovies(entities);
      return response.movies;
    } catch (e, s) {
      // logger.e('Upcoming movies failed', e, s);
      final cachedMovies = await database.movieDao.getAllMovies();
      return cachedMovies.map(_entityToMovie).toList();
    }
  }


  Future<List<Movie>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    await database.searchHistoryDao.insertSearchHistory(
      SearchHistoryEntity(
        query: query,
        searchedAtMillis: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    final response = await apiClient.searchMovies(apiKey, query, page);
    return response.movies;
  }


  Future<MovieDetail> getMovieDetail(int movieId) async {
    final cached =
    await database.movieDetailDao.getMovieDetailById(movieId);

    if (cached != null) {
      return _detailEntityToMovieDetail(cached);
    }

    final detail = await apiClient.getMovieDetail(movieId, apiKey);

    await database.movieDetailDao.insertMovieDetail(
      MovieDetailEntity(
        id: detail.id,
        title: detail.title,
        overview: detail.overview,
        posterPath: detail.posterPath,
        backdropPath: detail.backdropPath,
        releaseDate: detail.releaseDate,
        rating: detail.rating,
        runtime: detail.runtime,
        budget: detail.budget,
        revenue: detail.revenue,
        genres: detail.genres.map((g) => g.name).join(','),
        cachedAtMillis: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    return detail;
  }

  Future<List<Video>> getMovieVideos(int movieId) async {
    final response = await apiClient.getMovieVideos(movieId, apiKey);
    return response.results;
  }

  Future<ImageResponse> getMovieImages(int movieId) async {
    return await apiClient.getMovieImages(movieId, apiKey);
  }


  Future<void> clearExpiredCache() async {
    final expiryMillis = DateTime.now()
        .subtract(const Duration(hours: CACHE_DURATION_HOURS))
        .millisecondsSinceEpoch;

    await database.movieDao.deleteExpiredMovies(expiryMillis);
    await database.movieDetailDao.deleteExpiredMovieDetails(expiryMillis);
  }

  Movie _entityToMovie(MovieEntity entity) {
    return Movie(
      id: entity.id,
      title: entity.title,
      overview: entity.overview,
      posterPath: entity.posterPath,
      backdropPath: entity.backdropPath,
      releaseDate: entity.releaseDate,
      rating: entity.rating,
      genreIds:
      entity.genreIds?.split(',').map((e) => int.parse(e)).toList(),
    );
  }

  MovieDetail _detailEntityToMovieDetail(MovieDetailEntity entity) {
    final genres = entity.genres
        ?.split(',')
        .map((name) => Genre(id: name.hashCode, name: name))
        .toList() ??
        [];

    return MovieDetail(
      id: entity.id,
      title: entity.title,
      overview: entity.overview,
      posterPath: entity.posterPath,
      backdropPath: entity.backdropPath,
      releaseDate: entity.releaseDate,
      rating: entity.rating,
      runtime: entity.runtime,
      budget: entity.budget,
      revenue: entity.revenue,
      genres: genres,
      productionCompanies: const [],
    );
  }
}
