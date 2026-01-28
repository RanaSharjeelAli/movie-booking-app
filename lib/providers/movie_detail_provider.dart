import 'package:flutter/material.dart';
import '../models/tmdb_models.dart';
import '../repositories/movie_repository.dart';

class MovieDetailProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  MovieDetail? _movieDetail;
  List<Video> _videos = [];
  ImageResponse? _images;

  bool _isLoading = false;
  bool _isLoadingVideos = false;
  String? _errorMessage;
  int? _currentMovieId;

  MovieDetailProvider({required this.movieRepository});

  MovieDetail? get movieDetail => _movieDetail;
  List<Video> get videos => _videos;
  ImageResponse? get images => _images;
  bool get isLoading => _isLoading;
  bool get isLoadingVideos => _isLoadingVideos;
  String? get errorMessage => _errorMessage;
  int? get currentMovieId => _currentMovieId;

  Future<void> loadMovieDetail(int movieId) async {
    _currentMovieId = movieId;
    _movieDetail = null;
    _setLoading(true);
    notifyListeners();

    try {
      final detail = await movieRepository.getMovieDetail(movieId);
      _movieDetail = detail;
    } catch (e) {
      _setError('Failed to load movie detail: ${e.toString()}');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }


  Future<void> loadMovieVideos(int movieId) async {
    _setLoadingVideos(true);

    try {
      final videos = await movieRepository.getMovieVideos(movieId);
      _videos = videos;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load videos: ${e.toString()}');
    } finally {
      _setLoadingVideos(false);
    }
  }

  Future<void> loadMovieImages(int movieId) async {
    try {
      final images = await movieRepository.getMovieImages(movieId);
      _images = images;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load images: ${e.toString()}');
    }
  }

  void clear() {
    _movieDetail = null;
    _videos.clear();
    _images = null;
    _errorMessage = null;
    _currentMovieId = null;
    _isLoading = false;
    _isLoadingVideos = false;
    notifyListeners();
  }


  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _setLoadingVideos(bool value) {
    _isLoadingVideos = value;
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}