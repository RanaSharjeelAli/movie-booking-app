import 'package:json_annotation/json_annotation.dart';

part 'tmdb_models.g.dart';

// Movie Response Models
@JsonSerializable()
class MovieListResponse {
  @JsonKey(name: 'results')
  final List<Movie> movies;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MovieListResponse({
    required this.movies,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'vote_average')
  final double rating;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.rating,
    this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String get posterUrl => posterPath != null && posterPath!.isNotEmpty && posterPath != '/'
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';

  String get backdropUrl => backdropPath != null && backdropPath!.isNotEmpty && backdropPath != '/'
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : '';
}

@JsonSerializable()
class MovieDetail {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  @JsonKey(name: 'vote_average')
  final double rating;

  @JsonKey(name: 'runtime')
  final int runtime;

  @JsonKey(name: 'budget')
  final int budget;

  @JsonKey(name: 'revenue')
  final int revenue;

  @JsonKey(name: 'genres')
  final List<Genre> genres;

  @JsonKey(name: 'production_companies')
  final List<ProductionCompany> productionCompanies;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.rating,
    required this.runtime,
    required this.budget,
    required this.revenue,
    required this.genres,
    required this.productionCompanies,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

  String get posterUrl => posterPath != null && posterPath!.isNotEmpty && posterPath != '/'
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : '';

  String get backdropUrl => backdropPath != null && backdropPath!.isNotEmpty && backdropPath != '/'
      ? 'https://image.tmdb.org/t/p/original$backdropPath'
      : '';
}

@JsonSerializable()
class Genre {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable()
class ProductionCompany {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class VideoResponse {
  @JsonKey(name: 'results')
  final List<Video> results;

  VideoResponse({required this.results});

  factory VideoResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VideoResponseToJson(this);
}

@JsonSerializable()
class Video {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'site')
  final String site;

  @JsonKey(name: 'type')
  final String type;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: 'posters')
  final List<PosterImage>? posters;

  @JsonKey(name: 'backdrops')
  final List<BackdropImage>? backdrops;

  ImageResponse({
    this.posters,
    this.backdrops,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}

@JsonSerializable()
class PosterImage {
  @JsonKey(name: 'file_path')
  final String filePath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  PosterImage({
    required this.filePath,
    required this.voteAverage,
  });

  factory PosterImage.fromJson(Map<String, dynamic> json) =>
      _$PosterImageFromJson(json);
  Map<String, dynamic> toJson() => _$PosterImageToJson(this);
}

@JsonSerializable()
class BackdropImage {
  @JsonKey(name: 'file_path')
  final String filePath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  BackdropImage({
    required this.filePath,
    required this.voteAverage,
  });

  factory BackdropImage.fromJson(Map<String, dynamic> json) =>
      _$BackdropImageFromJson(json);
  Map<String, dynamic> toJson() => _$BackdropImageToJson(this);
}