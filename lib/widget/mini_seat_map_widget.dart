import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_demo_project/screens/seat_selection_screen.dart' show ScreenPainter;
import 'package:movie_demo_project/screens/selection_detail_screen.dart';
import 'package:movie_demo_project/widget/screen_painter_widget.dart';
import 'package:provider/provider.dart';
import '../config/app_assets.dart';
import '../config/seat_type_enum.dart';
import '../models/show_data_time_model.dart';
import '../providers/booking_provider.dart';
import '../config/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widget/show_time_card_widget.dart';

class MiniSeatMapWidget extends StatelessWidget {
  const MiniSeatMapWidget({super.key});

  static const int rows = 8;
  static const int leftSeats = 5;
  static const int middleSeats = 15;
  static const int rightSeats = 5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final curveWidth = screenWidth > 360 ? 360.0 : screenWidth * 0.9;
        final availableWidth = curveWidth - 32; // Account for spacing (16+16)
        
        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: curveWidth,
            child: Column(
              children: [
                CustomPaint(
                  size: Size(curveWidth, 18),
                  painter: ScreenPainter(),
                ),

                const SizedBox(height: 10),

                Column(
                  children: List.generate(rows, (row) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: availableWidth * (leftSeats / (leftSeats + (row == 1 ? 8 : middleSeats) + rightSeats)),
                            child: _seatBlock(leftSeats, row),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: availableWidth * ((row == 1 ? 8 : middleSeats) / (leftSeats + (row == 1 ? 8 : middleSeats) + rightSeats)),
                            child: _seatBlock(
                              row == 1 ? 8 : middleSeats,
                              row,
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: availableWidth * (rightSeats / (leftSeats + (row == 1 ? 8 : middleSeats) + rightSeats)),
                            child: _seatBlock(rightSeats, row),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _seatBlock(int count, int row) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(count, (col) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: _getMiniSeat(row, col),
          ),
        );
      }),
    );
  }

  Widget _getMiniSeat(int row, int col) {
    SeatType type;

    if (row == 0) {
      type = SeatType.unavailable;
    } else if (row == 2 && (col == 2 || col == 5)) {
      type = SeatType.selected;
    } else if (row == 3 && col % 3 == 0) {
      type = SeatType.vip;
    } else if (row == 5 && col == 2) {
      type = SeatType.selected;
    } else if (row == 6 && col % 2 == 0) {
      type = SeatType.green;
    } else {
      type = SeatType.available;
    }

    return _buildSeatIcon(type, null);
  }

  Widget _buildSeatIcon(SeatType type, bool? isSelected) {
    Color color;

    if (isSelected == true) {
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
      width: 6,
      height: 6,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

}
