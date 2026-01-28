import 'package:flutter/material.dart';
import 'package:movie_demo_project/widget/main_shell.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

// Import all services, repositories, and providers
import 'services/tmdb_api_client.dart';
import 'database/app_database.dart';
import 'repositories/movie_repository.dart';
import 'repositories/booking_repository.dart';
import 'providers/movie_list_provider.dart';
import 'providers/movie_detail_provider.dart';
import 'providers/booking_provider.dart';
import 'config/app_theme.dart';
import 'screens/movie_list_screen.dart';

late AppDatabase _database;
late Logger _logger;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _initializeLogger();

  try {
    await _initializeDatabase();
    _logger.i('Database initialized successfully');
  } catch (e) {
    _logger.e('Failed to initialize database: $e');
  }

  runApp(const MyApp());
}

void _initializeLogger() {
  _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );
  _logger.i('Logger initialized');
}

Future<void> _initializeDatabase() async {
  _database =
      await $FloorAppDatabase.databaseBuilder('movie_booking_app.db').build();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = _configureDio();
    final apiClient = TMDbApiClient(dio);

    return MultiProvider(
      providers: [
        Provider<TMDbApiClient>(create: (_) => apiClient),
        Provider<AppDatabase>(create: (_) => _database),
        Provider<MovieRepository>(
          create:
              (context) => MovieRepository(
                apiClient: context.read<TMDbApiClient>(),
                database: context.read<AppDatabase>(),
              ),
          lazy: false,
        ),
        ChangeNotifierProvider<MovieListProvider>(
          create:
              (context) => MovieListProvider(
                movieRepository: context.read<MovieRepository>(),
              ),
          lazy: true,
        ),
        ChangeNotifierProvider<MovieDetailProvider>(
          create:
              (context) => MovieDetailProvider(
                movieRepository: context.read<MovieRepository>(),
              ),
          lazy: true,
        ),
        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Booking App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const MainShell(),
      ),
    );
  }

  Dio _configureDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LoggingInterceptor(logger: _logger));

    return dio;
  }
}

class LoggingInterceptor extends Interceptor {
  final Logger logger;

  LoggingInterceptor({required this.logger});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d(
      '→ REQUEST\n'
      'Method: ${options.method}\n'
      'Path: ${options.path}\n'
      'Headers: ${options.headers}\n'
      'QueryParams: ${options.queryParameters}',
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      '← RESPONSE\n'
      'Status Code: ${response.statusCode}\n'
      'Data: ${response.data}',
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      '✗ ERROR\n'
      'Type: ${err.type}\n'
      'Message: ${err.message}\n'
      'Response: ${err.response?.data}',
    );
    return handler.next(err);
  }
}
