import 'package:flutter/material.dart';

import '../config/seat_type_enum.dart';

class BookingProvider extends ChangeNotifier {
  String movieTitle = 'The King\'s Man';
  String releaseText = 'In Theaters December 22, 2021';
  String releaseDate = 'December 22, 2021';

  int selectedDateIndex = 0;
  int selectedShowtimeIndex = 0;

  static const int rows = 11;
  static const int leftSeats = 5;
  static const int middleSeats = 15;
  static const int rightSeats = 5;

  static int get totalSeatsPerRow =>
      leftSeats + middleSeats + rightSeats;

  final Map<String, SeatType> _selectedSeats = {};

  Map<String, SeatType> get selectedSeats => _selectedSeats;

  static const double regularPrice = 50;
  static const double vipPrice = 150;

  double get totalPrice {
    double total = 0;
    for (final type in _selectedSeats.values) {
      total += type == SeatType.vip ? vipPrice : regularPrice;
    }
    return total;
  }

  void setMovie({
    required String title,
    required String release,
    required String releaseD,
  }) {
    movieTitle = title;
    releaseText = release;
    releaseDate = releaseD;
    notifyListeners();
  }

  void setDateIndex(int index) {
    selectedDateIndex = index;
    notifyListeners();
  }

  void setShowtimeIndex(int index) {
    selectedShowtimeIndex = index;
    notifyListeners();
  }

  void toggleSeat(String seatId, SeatType type) {
    if (_selectedSeats.containsKey(seatId)) {
      _selectedSeats.remove(seatId);
    } else {
      _selectedSeats[seatId] = type;
    }
    notifyListeners();
  }

  void clearSeats() {
    _selectedSeats.clear();
    notifyListeners();
  }

  bool isSeatSelected(String seatId) =>
      _selectedSeats.containsKey(seatId);

  SeatType getSeatType(int row, int col) {
    if (row == 0 || row == rows - 1) {
      return SeatType.unavailable;
    }

    if ((row == 5 || row == 6) && col % 4 == 0) {
      return SeatType.vip;
    }

    if ((row == 4 || row == 7) && col % 5 == 0) {
      return SeatType.green;
    }

    return SeatType.available;
  }
}
