import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/booking_provider.dart';
import 'package:provider/provider.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widget/bottom_section_detail.dart';
import '../widget/detail_seat_map_widget.dart';

class DetailedSeatMapScreen extends StatefulWidget {
  const DetailedSeatMapScreen({super.key});

  @override
  State<DetailedSeatMapScreen> createState() => _DetailedSeatMapScreenState();
}

class _DetailedSeatMapScreenState extends State<DetailedSeatMapScreen> {
  double _zoomLevel = 1.0;

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + 0.1).clamp(0.5, 2.0);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - 0.1).clamp(0.5, 2.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: _buildDetailAppBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Transform.scale(
                    scale: _zoomLevel,
                    child: const Column(children: [DetailedSeatMapWidget()]),
                  ),
                ),
              ),
              buildBottomSection(context),
            ],
          ),
          // Zoom controls positioned on the right
          Positioned(
            right: ResponsiveUtils.getResponsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
            top: ResponsiveUtils.getResponsiveValue(context, mobile: 420, tablet: 380, desktop: 340),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Minus button
                Container(
                  width: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 44, desktop: 48),
                  height: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 44, desktop: 48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _zoomOut,
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: ResponsiveUtils.getResponsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16)),
                // Plus button
                Container(
                  width: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 44, desktop: 48),
                  height: ResponsiveUtils.getResponsiveValue(context, mobile: 40, tablet: 44, desktop: 48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _zoomIn,
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: ResponsiveUtils.getResponsiveValue(context, mobile: 20, tablet: 22, desktop: 24),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildDetailAppBar(BuildContext context) {
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
        builder:
            (context, provider, _) => Column(
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
                  '${provider.releaseDate} · ${provider.selectedShowtimeIndex == 0 ? '12:30' : '13:30'} Hall 1',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
