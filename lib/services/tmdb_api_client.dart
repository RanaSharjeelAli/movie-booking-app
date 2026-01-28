import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models/tmdb_models.dart';

part 'tmdb_api_client.g.dart';

@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class TMDbApiClient {
  factory TMDbApiClient(Dio dio, {String baseUrl}) = _TMDbApiClient;

  @GET('/movie/upcoming')
  Future<MovieListResponse> getUpcomingMovies(
      @Query('api_key') String apiKey,
      @Query('page') int page,
      );

  @GET('/movie/{movie_id}')
  Future<MovieDetail> getMovieDetail(
      @Path('movie_id') int movieId,
      @Query('api_key') String apiKey,
      );

  @GET('/movie/{movie_id}/videos')
  Future<VideoResponse> getMovieVideos(
      @Path('movie_id') int movieId,
      @Query('api_key') String apiKey,
      );

  @GET('/movie/{movie_id}/images')
  Future<ImageResponse> getMovieImages(
      @Path('movie_id') int movieId,
      @Query('api_key') String apiKey,
      );

  @GET('/search/movie')
  Future<MovieListResponse> searchMovies(
      @Query('api_key') String apiKey,
      @Query('query') String query,
      @Query('page') int page,
      );
}
