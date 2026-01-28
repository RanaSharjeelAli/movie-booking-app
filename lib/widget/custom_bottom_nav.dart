import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_demo_project/config/app_assets.dart';

import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.getResponsiveValue(context, mobile: 68, tablet: 72, desktop: 76),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
       color: AppColors.bottomBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: AppImages.icDash,
            label: 'Dashboard',
            selected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: AppImages.icMusic,
            label: 'Watch',
            selected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavItem(
            icon: AppImages.icLib,
            label: 'Media Library',
            selected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavItem(
            icon: AppImages.icMore,
            label: 'More',
            selected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.white54;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon,
            height: ResponsiveUtils.getResponsiveValue(context, mobile: 24, tablet: 26, desktop: 28),
            width: ResponsiveUtils.getResponsiveValue(context, mobile: 24, tablet: 26, desktop: 28),
            color: color,
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveValue(context, mobile: 4, tablet: 5, desktop: 6)),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: ResponsiveUtils.getFontSize(context, mobile: 10, tablet: 11, desktop: 12),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
