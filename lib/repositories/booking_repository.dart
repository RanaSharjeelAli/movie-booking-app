import 'package:logger/logger.dart';
import '../database/app_database.dart';
import '../database/entities.dart';

class BookingModel {
  final int? id;
  final int movieId;
  final String movieTitle;
  final String selectedDate;
  final String selectedTime;
  final String selectedSeats;
  final double totalPrice;
  final DateTime bookedAt;

  BookingModel({
    this.id,
    required this.movieId,
    required this.movieTitle,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSeats,
    required this.totalPrice,
    required this.bookedAt,
  });

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      movieId: movieId,
      movieTitle: movieTitle,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      selectedSeats: selectedSeats,
      totalPrice: totalPrice,
      bookedAtMillis: bookedAt.millisecondsSinceEpoch,
    );
  }

  static BookingModel fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      movieId: entity.movieId,
      movieTitle: entity.movieTitle,
      selectedDate: entity.selectedDate,
      selectedTime: entity.selectedTime,
      selectedSeats: entity.selectedSeats,
      totalPrice: entity.totalPrice,
      bookedAt: entity.bookedAt,
    );
  }
}
