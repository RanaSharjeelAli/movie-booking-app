import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';

class SearchMovieCard extends StatelessWidget {
  final dynamic movie;
  final VoidCallback onTap;

  const SearchMovieCard({required this.movie, required this.onTap});

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
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _getValidImageUrl(movie.backdropUrl, movie.posterUrl),
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

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                ),
              ),
            ),

            // Title
            Positioned(
              left: 12,
              bottom: 22,
              right: 12,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
