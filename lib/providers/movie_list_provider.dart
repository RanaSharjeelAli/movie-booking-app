import 'package:flutter/material.dart';
import '../models/tmdb_models.dart';
import '../repositories/movie_repository.dart';

class MovieListProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  List<Movie> _upcomingMovies = [];
  List<Movie> _searchResults = [];

  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;
  String? _lastSearchQuery;
  int _currentPage = 1;

  MovieListProvider({required this.movieRepository});

  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;
  String? get lastSearchQuery => _lastSearchQuery;
  int get currentPage => _currentPage;

  Future<void> loadUpcomingMovies({bool forceRefresh = false}) async {
    _setLoading(true);
    _clearError();

    try {
      final movies = await movieRepository.getUpcomingMovies(
        page: _currentPage,
        forceRefresh: forceRefresh,
      );

      _upcomingMovies = movies;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load movies: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults.clear();
      _lastSearchQuery = null;
      notifyListeners();
      return;
    }

    _setSearching(true);
    _clearError();

    try {
      _lastSearchQuery = query;
      final results = await movieRepository.searchMovies(query: query);
      _searchResults = results;
      notifyListeners();
    } catch (e) {
      _setError('Failed to search movies: ${e.toString()}');
    } finally {
      _setSearching(false);
    }
  }

  void clearSearch() {
    _searchResults.clear();
    _lastSearchQuery = null;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    _currentPage++;
    await loadUpcomingMovies();
  }

  void resetPagination() {
    _currentPage = 1;
  }

  Future<void> clearExpiredCache() async {
    try {
      await movieRepository.clearExpiredCache();
      notifyListeners();
    } catch (e) {
      _setError('Failed to clear cache: ${e.toString()}');
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}