import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_theme.dart';
import '../models/show_data_time_model.dart';
import '../screens/seat_selection_screen.dart';
import 'mini_seat_map_widget.dart';

class ShowTimeCard extends StatelessWidget {
  final ShowtimeData data;
  final bool isSelected;

  const ShowTimeCard({super.key, required this.data, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                data.time,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  data.hall,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subHeadTextColor,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.lightBlueColor : AppColors.white,
              width: 1.5,
            ),
          ),
          child: AspectRatio(aspectRatio: 16 / 9, child: MiniSeatMapWidget()),
        ),

        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'From ',
                    style: GoogleFonts.poppins(
                      color: AppColors.subHeadTextColor,
                    ), // grey
                  ),
                  TextSpan(
                    text: '50\$ ',
                    style: GoogleFonts.poppins(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ), // blue
                  ),
                  TextSpan(
                    text: 'or ',
                    style: GoogleFonts.poppins(
                      color: AppColors.subHeadTextColor,
                    ), // grey
                  ),
                  TextSpan(
                    text: '2500 bonus',
                    style: GoogleFonts.poppins(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ), // dark
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
