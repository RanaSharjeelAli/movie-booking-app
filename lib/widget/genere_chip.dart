import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_theme.dart';

class GenreChip extends StatelessWidget {
  final String label;
  final Color color;

  const GenreChip(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      side: BorderSide.none,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelStyle: GoogleFonts.poppins(color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 12),
    );
  }
}
