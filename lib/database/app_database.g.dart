// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  MovieDetailDao? _movieDetailDaoInstance;

  BookingDao? _bookingDaoInstance;

  SearchHistoryDao? _searchHistoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieEntity` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `overview` TEXT NOT NULL, `posterPath` TEXT, `backdropPath` TEXT, `releaseDate` TEXT NOT NULL, `rating` REAL NOT NULL, `genreIds` TEXT, `cached_at` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieDetailEntity` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `overview` TEXT NOT NULL, `posterPath` TEXT, `backdropPath` TEXT, `releaseDate` TEXT NOT NULL, `rating` REAL NOT NULL, `runtime` INTEGER NOT NULL, `budget` INTEGER NOT NULL, `revenue` INTEGER NOT NULL, `genres` TEXT, `cached_at` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BookingEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `movieId` INTEGER NOT NULL, `movieTitle` TEXT NOT NULL, `selectedDate` TEXT NOT NULL, `selectedTime` TEXT NOT NULL, `selectedSeats` TEXT NOT NULL, `totalPrice` REAL NOT NULL, `booked_at` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SearchHistoryEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `query` TEXT NOT NULL, `searched_at` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  MovieDetailDao get movieDetailDao {
    return _movieDetailDaoInstance ??=
        _$MovieDetailDao(database, changeListener);
  }

  @override
  BookingDao get bookingDao {
    return _bookingDaoInstance ??= _$BookingDao(database, changeListener);
  }

  @override
  SearchHistoryDao get searchHistoryDao {
    return _searchHistoryDaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'MovieEntity',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'backdropPath': item.backdropPath,
                  'releaseDate': item.releaseDate,
                  'rating': item.rating,
                  'genreIds': item.genreIds,
                  'cached_at': item.cachedAtMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    return _queryAdapter.queryList(
        'SELECT * FROM MovieEntity ORDER BY releaseDate DESC',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String?,
            backdropPath: row['backdropPath'] as String?,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double,
            genreIds: row['genreIds'] as String?,
            cachedAtMillis: row['cached_at'] as int));
  }

  @override
  Future<MovieEntity?> getMovieById(int movieId) async {
    return _queryAdapter.query('SELECT * FROM MovieEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String?,
            backdropPath: row['backdropPath'] as String?,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double,
            genreIds: row['genreIds'] as String?,
            cachedAtMillis: row['cached_at'] as int),
        arguments: [movieId]);
  }

  @override
  Future<void> deleteExpiredMovies(int expiryMillis) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM MovieEntity WHERE cached_at < ?1',
        arguments: [expiryMillis]);
  }

  @override
  Future<void> clearAllMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MovieEntity');
  }

  @override
  Future<void> insertMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMovies(List<MovieEntity> movies) async {
    await _movieEntityInsertionAdapter.insertList(
        movies, OnConflictStrategy.abort);
  }
}

class _$MovieDetailDao extends MovieDetailDao {
  _$MovieDetailDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieDetailEntityInsertionAdapter = InsertionAdapter(
            database,
            'MovieDetailEntity',
            (MovieDetailEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'backdropPath': item.backdropPath,
                  'releaseDate': item.releaseDate,
                  'rating': item.rating,
                  'runtime': item.runtime,
                  'budget': item.budget,
                  'revenue': item.revenue,
                  'genres': item.genres,
                  'cached_at': item.cachedAtMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieDetailEntity> _movieDetailEntityInsertionAdapter;

  @override
  Future<MovieDetailEntity?> getMovieDetailById(int movieId) async {
    return _queryAdapter.query('SELECT * FROM MovieDetailEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieDetailEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String?,
            backdropPath: row['backdropPath'] as String?,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double,
            runtime: row['runtime'] as int,
            budget: row['budget'] as int,
            revenue: row['revenue'] as int,
            genres: row['genres'] as String?,
            cachedAtMillis: row['cached_at'] as int),
        arguments: [movieId]);
  }

  @override
  Future<void> deleteExpiredMovieDetails(int expiryMillis) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM MovieDetailEntity WHERE cached_at < ?1',
        arguments: [expiryMillis]);
  }

  @override
  Future<void> clearAllMovieDetails() async {
    await _queryAdapter.queryNoReturn('DELETE FROM MovieDetailEntity');
  }

  @override
  Future<void> insertMovieDetail(MovieDetailEntity movie) async {
    await _movieDetailEntityInsertionAdapter.insert(
        movie, OnConflictStrategy.abort);
  }
}

class _$BookingDao extends BookingDao {
  _$BookingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookingEntityInsertionAdapter = InsertionAdapter(
            database,
            'BookingEntity',
            (BookingEntity item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'movieTitle': item.movieTitle,
                  'selectedDate': item.selectedDate,
                  'selectedTime': item.selectedTime,
                  'selectedSeats': item.selectedSeats,
                  'totalPrice': item.totalPrice,
                  'booked_at': item.bookedAtMillis
                }),
        _bookingEntityDeletionAdapter = DeletionAdapter(
            database,
            'BookingEntity',
            ['id'],
            (BookingEntity item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'movieTitle': item.movieTitle,
                  'selectedDate': item.selectedDate,
                  'selectedTime': item.selectedTime,
                  'selectedSeats': item.selectedSeats,
                  'totalPrice': item.totalPrice,
                  'booked_at': item.bookedAtMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookingEntity> _bookingEntityInsertionAdapter;

  final DeletionAdapter<BookingEntity> _bookingEntityDeletionAdapter;

  @override
  Future<List<BookingEntity>> getAllBookings() async {
    return _queryAdapter.queryList(
        'SELECT * FROM BookingEntity ORDER BY booked_at DESC',
        mapper: (Map<String, Object?> row) => BookingEntity(
            id: row['id'] as int?,
            movieId: row['movieId'] as int,
            movieTitle: row['movieTitle'] as String,
            selectedDate: row['selectedDate'] as String,
            selectedTime: row['selectedTime'] as String,
            selectedSeats: row['selectedSeats'] as String,
            totalPrice: row['totalPrice'] as double,
            bookedAtMillis: row['booked_at'] as int));
  }

  @override
  Future<BookingEntity?> getBookingById(int bookingId) async {
    return _queryAdapter.query('SELECT * FROM BookingEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BookingEntity(
            id: row['id'] as int?,
            movieId: row['movieId'] as int,
            movieTitle: row['movieTitle'] as String,
            selectedDate: row['selectedDate'] as String,
            selectedTime: row['selectedTime'] as String,
            selectedSeats: row['selectedSeats'] as String,
            totalPrice: row['totalPrice'] as double,
            bookedAtMillis: row['booked_at'] as int),
        arguments: [bookingId]);
  }

  @override
  Future<List<BookingEntity>> getBookingsByMovie(int movieId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM BookingEntity WHERE movieId = ?1',
        mapper: (Map<String, Object?> row) => BookingEntity(
            id: row['id'] as int?,
            movieId: row['movieId'] as int,
            movieTitle: row['movieTitle'] as String,
            selectedDate: row['selectedDate'] as String,
            selectedTime: row['selectedTime'] as String,
            selectedSeats: row['selectedSeats'] as String,
            totalPrice: row['totalPrice'] as double,
            bookedAtMillis: row['booked_at'] as int),
        arguments: [movieId]);
  }

  @override
  Future<void> clearAllBookings() async {
    await _queryAdapter.queryNoReturn('DELETE FROM BookingEntity');
  }

  @override
  Future<int> insertBooking(BookingEntity booking) {
    return _bookingEntityInsertionAdapter.insertAndReturnId(
        booking, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBooking(BookingEntity booking) async {
    await _bookingEntityDeletionAdapter.delete(booking);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _searchHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'SearchHistoryEntity',
            (SearchHistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'query': item.query,
                  'searched_at': item.searchedAtMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchHistoryEntity>
      _searchHistoryEntityInsertionAdapter;

  @override
  Future<List<SearchHistoryEntity>> getRecentSearches() async {
    return _queryAdapter.queryList(
        'SELECT * FROM SearchHistoryEntity ORDER BY searched_at DESC LIMIT 10',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            id: row['id'] as int?,
            query: row['query'] as String,
            searchedAtMillis: row['searched_at'] as int));
  }

  @override
  Future<void> deleteExpiredSearchHistory(int expiryMillis) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SearchHistoryEntity WHERE searched_at < ?1',
        arguments: [expiryMillis]);
  }

  @override
  Future<void> clearAllSearchHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SearchHistoryEntity');
  }

  @override
  Future<void> insertSearchHistory(SearchHistoryEntity search) async {
    await _searchHistoryEntityInsertionAdapter.insert(
        search, OnConflictStrategy.abort);
  }
}
