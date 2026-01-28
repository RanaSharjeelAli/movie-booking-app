import 'package:floor/floor.dart';
import 'entities.dart';

@dao
abstract class MovieDao {
  @insert
  Future<void> insertMovie(MovieEntity movie);

  @insert
  Future<void> insertMovies(List<MovieEntity> movies);

  @Query('SELECT * FROM MovieEntity ORDER BY releaseDate DESC')
  Future<List<MovieEntity>> getAllMovies();

  @Query('SELECT * FROM MovieEntity WHERE id = :movieId')
  Future<MovieEntity?> getMovieById(int movieId);

  // ✅ FIXED
  @Query('DELETE FROM MovieEntity WHERE cached_at < :expiryMillis')
  Future<void> deleteExpiredMovies(int expiryMillis);

  @Query('DELETE FROM MovieEntity')
  Future<void> clearAllMovies();
}

@dao
abstract class MovieDetailDao {
  @insert
  Future<void> insertMovieDetail(MovieDetailEntity movie);

  @Query('SELECT * FROM MovieDetailEntity WHERE id = :movieId')
  Future<MovieDetailEntity?> getMovieDetailById(int movieId);

  // ✅ FIXED
  @Query('DELETE FROM MovieDetailEntity WHERE cached_at < :expiryMillis')
  Future<void> deleteExpiredMovieDetails(int expiryMillis);

  @Query('DELETE FROM MovieDetailEntity')
  Future<void> clearAllMovieDetails();
}

@dao
abstract class BookingDao {
  @insert
  Future<int> insertBooking(BookingEntity booking);

  @Query('SELECT * FROM BookingEntity ORDER BY booked_at DESC')
  Future<List<BookingEntity>> getAllBookings();

  @Query('SELECT * FROM BookingEntity WHERE id = :bookingId')
  Future<BookingEntity?> getBookingById(int bookingId);

  @Query('SELECT * FROM BookingEntity WHERE movieId = :movieId')
  Future<List<BookingEntity>> getBookingsByMovie(int movieId);

  @delete
  Future<void> deleteBooking(BookingEntity booking);

  @Query('DELETE FROM BookingEntity')
  Future<void> clearAllBookings();
}

@dao
abstract class SearchHistoryDao {
  @insert
  Future<void> insertSearchHistory(SearchHistoryEntity search);

  @Query('SELECT * FROM SearchHistoryEntity ORDER BY searched_at DESC LIMIT 10')
  Future<List<SearchHistoryEntity>> getRecentSearches();

  // ✅ FIXED
  @Query('DELETE FROM SearchHistoryEntity WHERE searched_at < :expiryMillis')
  Future<void> deleteExpiredSearchHistory(int expiryMillis);

  @Query('DELETE FROM SearchHistoryEntity')
  Future<void> clearAllSearchHistory();
}
