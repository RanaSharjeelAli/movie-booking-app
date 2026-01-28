import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, InputDecoration, OutlineInputBorder, TextFormField;
import 'package:google_fonts/google_fonts.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';

class SearchBarField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;

  const SearchBarField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.backgroundColor1,
        hintText: 'TV shows, movies and more',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.searchTextColor,
        ),

        // 🔍 search icon
        prefixIcon: Image.asset(
          AppImages.icSearch,
          color: AppColors.textColor,
          height: 20,
          width: 20,
        ),

        suffixIcon:
        controller.text.isNotEmpty
            ? GestureDetector(
          onTap: onClear,
          child: Image.asset(
            AppImages.icClose,
            height: 30,
            width: 30,
            color: AppColors.textColor,
          ),
        )
            : null,

        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
