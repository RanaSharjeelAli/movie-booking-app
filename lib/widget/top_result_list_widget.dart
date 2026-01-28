import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';

class TopResultsList extends StatelessWidget {
  final List movies;
  final Function(dynamic movie) onTap;

  const TopResultsList({super.key, required this.movies, required this.onTap});

  String _getValidImageUrl(String posterUrl, String backdropUrl) {
    if (posterUrl.isNotEmpty && _isValidUrl(posterUrl)) {
      return posterUrl;
    }
    if (backdropUrl.isNotEmpty && _isValidUrl(backdropUrl)) {
      return backdropUrl;
    }
    return '';
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: movies.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Results',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 4),
                Divider(color: AppColors.backgroundColor, thickness: 1),
              ],
            ),
          );
        }

        final movie = movies[index - 1];

        return GestureDetector(
          onTap: () => onTap(movie),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // 🎬 Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: _getValidImageUrl(movie.posterUrl, movie.backdropUrl),
                  width: 130,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _fakeGenre(movie),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),

              Image.asset(AppImages.icHoriz),
            ],
          ),
          ),
        );
      },
    );
  }

  String _fakeGenre(dynamic movie) {
    final t = movie.title.toLowerCase();
    if (t.contains('time')) return 'Sci-Fi';
    if (t.contains('kill')) return 'Crime';
    return 'Fantasy';
  }
}
