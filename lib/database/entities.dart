import 'package:floor/floor.dart';

/// Movie Entity - represents a cached movie from API
/// DateTime is stored as int (milliseconds since epoch) for Floor compatibility
@entity
class MovieEntity {
  @PrimaryKey()
  final int id;

  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double rating;
  final String? genreIds;

  /// Cached timestamp in milliseconds since epoch
  @ColumnInfo(name: 'cached_at')
  final int cachedAtMillis;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.rating,
    this.genreIds,
    required this.cachedAtMillis,
  });

  /// Helper to convert to DateTime
  DateTime get cachedAt => DateTime.fromMillisecondsSinceEpoch(cachedAtMillis);
}

/// Movie Detail Entity - represents detailed movie information
@entity
class MovieDetailEntity {
  @PrimaryKey()
  final int id;

  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double rating;
  final int runtime;
  final int budget;
  final int revenue;
  final String? genres;

  /// Cached timestamp in milliseconds since epoch
  @ColumnInfo(name: 'cached_at')
  final int cachedAtMillis;

  MovieDetailEntity({
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
    this.genres,
    required this.cachedAtMillis,
  });

  /// Helper to convert to DateTime
  DateTime get cachedAt => DateTime.fromMillisecondsSinceEpoch(cachedAtMillis);
}

/// Booking Entity - represents a movie ticket booking
@entity
class BookingEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int movieId;
  final String movieTitle;
  final String selectedDate;
  final String selectedTime;
  final String selectedSeats;
  final double totalPrice;

  /// Booking timestamp in milliseconds since epoch
  @ColumnInfo(name: 'booked_at')
  final int bookedAtMillis;

  BookingEntity({
    this.id,
    required this.movieId,
    required this.movieTitle,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSeats,
    required this.totalPrice,
    required this.bookedAtMillis,
  });

  /// Helper to convert to DateTime
  DateTime get bookedAt => DateTime.fromMillisecondsSinceEpoch(bookedAtMillis);
}

/// Search History Entity - represents a previous search
@entity
class SearchHistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String query;

  /// Search timestamp in milliseconds since epoch
  @ColumnInfo(name: 'searched_at')
  final int searchedAtMillis;

  SearchHistoryEntity({
    this.id,
    required this.query,
    required this.searchedAtMillis,
  });

  /// Helper to convert to DateTime
  DateTime get searchedAt => DateTime.fromMillisecondsSinceEpoch(searchedAtMillis);
}