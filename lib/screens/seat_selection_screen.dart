import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_demo_project/screens/selection_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/show_data_time_model.dart';
import '../providers/booking_provider.dart';
import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';

import '../widget/show_time_card_widget.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: ResponsiveUtils.getScreenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveUtils.getResponsiveValue(context, mobile: 100, tablet: 120, desktop: 140)),
            _buildDateSection(context),
            SizedBox(height: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 48, desktop: 56)),
            _buildShowtimeSection(context),
            const Spacer(),
            _buildSelectSeatsButton(context),
            SizedBox(height: ResponsiveUtils.getResponsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      toolbarHeight: 70,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Consumer<BookingProvider>(
        builder: (context, provider, _) =>
            Column(
              children: [
                Text(
                  provider.movieTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.releaseText,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.lightBlueColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildDateSection(BuildContext context) {
    final dates = List.generate(
      5,
          (i) => '${5 + i} Mar',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.getFontSize(context, mobile: 16, tablet: 18, desktop: 20),
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 44, desktop: 48),
          child: Consumer<BookingProvider>(
            builder: (context, provider, _) =>
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  separatorBuilder: (_, __) => SizedBox(width: ResponsiveUtils.getResponsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
                  itemBuilder: (context, index) {
                    final isSelected = provider.selectedDateIndex == index;
                    return GestureDetector(
                      onTap: () => provider.setDateIndex(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.getResponsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                          vertical: ResponsiveUtils.getResponsiveValue(context, mobile: 10, tablet: 11, desktop: 12),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.lightBlueColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            dates[index],
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.getFontSize(context, mobile: 12, tablet: 13, desktop: 14),
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors
                                  .textColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildShowtimeSection(BuildContext context) {
    final showtimes = [
      ShowtimeData(
        time: '12:30',
        hall: 'Cinetech + Hall 1',
        price: 'From 50\$ or 2500 bonus',
      ),
      ShowtimeData(
        time: '13:30',
        hall: 'Cinetech',
        price: 'From 75\$ or 3000 bonus',
      ),
    ];

    return Consumer<BookingProvider>(
      builder: (context, provider, _) =>
          Row(
            children: List.generate(
              showtimes.length,
                  (index) =>
                  Expanded(
                    child: GestureDetector(
                      onTap: () => provider.setShowtimeIndex(index),
                      child: ShowTimeCard(
                        data: showtimes[index],
                        isSelected: provider.selectedShowtimeIndex == index,
                      ),
                    ),
                  ),
            ),
          ),
    );
  }

  Widget _buildSelectSeatsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveUtils.getResponsiveValue(context, mobile: 52, tablet: 56, desktop: 60),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailedSeatMapScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlueColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Select Seats',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.getFontSize(context, mobile: 14, tablet: 16, desktop: 18),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}





