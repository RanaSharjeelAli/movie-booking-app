import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../config/app_theme.dart';
import '../providers/booking_provider.dart';
import 'legend_dot_widget.dart';

Widget buildBottomSection(BuildContext context) {
  return Consumer<BookingProvider>(
    builder: (context, provider, _) {
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LegendDot(color: AppColors.yellowColor, label: 'Selected'),
                      SizedBox(height: 20,),
                      LegendDot(
                        color: AppColors.purpleColor,
                        label: 'VIP (150\$)',
                      ),
                    ],
                  ),
                  SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LegendDot(color: AppColors.subHeadTextColor, label: 'not available'),
                      SizedBox(height: 20,),
                      LegendDot(
                        color: AppColors.lightBlueColor,
                        label: 'Regular (50\$)',
                      ),
                    ],
                  ),

                ],
              ),

              const SizedBox(height: 16),

              if (provider.selectedSeats.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${provider.selectedSeats.length} / row',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.close, size: 14,color: AppColors.textColor,),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    width: 108,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$ ${provider.totalPrice.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed:
                        provider.selectedSeats.isEmpty
                            ? null
                            : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Proceeding to pay \$${provider.totalPrice.toStringAsFixed(0)}',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightBlueColor,
                          disabledBackgroundColor: AppColors.lightBlueColor.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Proceed to pay',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
