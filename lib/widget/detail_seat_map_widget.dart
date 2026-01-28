import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_demo_project/widget/screen_painter_widget.dart';
import 'package:provider/provider.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';
import '../config/seat_type_enum.dart';
import '../providers/booking_provider.dart';
import '../screens/seat_selection_screen.dart'
    hide SeatType;

class DetailedSeatMapWidget extends StatelessWidget {
  const DetailedSeatMapWidget({super.key});

  static const int rows = 11;
  static const int leftSeats = 5;
  static const int middleSeats = 15;
  static const int rightSeats = 5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final curveWidth = screenWidth > 520 ? 520.0 : screenWidth * 0.9;
        
        return Column(
          children: [
            // Screen curve - outside of scroll
            Center(
              child: CustomPaint(size: Size(curveWidth, 24), painter: ScreenPainter()),
            ),
            const SizedBox(height: 16),
            
            // Seats - with horizontal scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: List.generate(rows, (row) {
                  final int middleCount = row == 3 ? 8 : middleSeats;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _seatBlock(context, leftSeats, row),
                        const SizedBox(width: 28), // aisle
                        _seatBlock(context, middleCount, row),
                        const SizedBox(width: 28), // aisle
                        _seatBlock(context, rightSeats, row),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _seatBlock(BuildContext context, int count, int row) {
    return Row(
      children: List.generate(count, (col) {
        final seatId = '${row}_$col';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Consumer<BookingProvider>(
            builder: (context, provider, _) {
              final seatType = provider.getSeatType(row, col);
              final isSelected = provider.isSeatSelected(seatId);

              return GestureDetector(
                onTap: () {
                  if (seatType != SeatType.unavailable) {
                    provider.toggleSeat(seatId, seatType);
                  }
                },

                child: _buildSeat(seatType, isSelected),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildSeat(SeatType type, bool isSelected) {
    Color color;

    if (isSelected) {
      color = AppColors.yellowColor;
    } else {
      switch (type) {
        case SeatType.vip:
          color = AppColors.purpleColor;
          break;
        case SeatType.green:
          color = AppColors.cyanColor;
          break;
        case SeatType.selected:
          color = AppColors.pinkColor;
          break;
        case SeatType.unavailable:
          color = AppColors.searchTextColor;
          break;
        default:
          color = AppColors.lightBlueColor;
      }
    }

    return SvgPicture.asset(
      AppImages.icSeat,
      width: 14,
      height: 14,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
