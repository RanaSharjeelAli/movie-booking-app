import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'daos.dart';
import 'entities.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [MovieEntity, MovieDetailEntity, BookingEntity, SearchHistoryEntity],
)
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  MovieDetailDao get movieDetailDao;
  BookingDao get bookingDao;
  SearchHistoryDao get searchHistoryDao;
}

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();

  static late AppDatabase _database;

  Future<AppDatabase> get database async {
    return _database;
  }

  static Future<void> initDatabase() async {
    _database = await $FloorAppDatabase
        .databaseBuilder('movie_booking_app.db')
        .build();
  }
}