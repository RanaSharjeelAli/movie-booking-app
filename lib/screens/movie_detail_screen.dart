import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/movie_detail_provider.dart';
import '../providers/booking_provider.dart';
import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widget/genere_chip.dart';
import 'seat_selection_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MovieDetailProvider>();
      provider.clear();
      provider.loadMovieDetail(widget.movieId);
      provider.loadMovieVideos(widget.movieId);
    });
  }

  String formatReleaseDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return DateFormat('MMMM d, y').format(DateTime.parse(date));
    } catch (_) {
      return '';
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MovieDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final movie = provider.movieDetail;
          if (movie == null) return const SizedBox();

          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: ResponsiveUtils.getResponsiveValue(
                      context,
                      mobile: MediaQuery.of(context).size.height * 0.55,
                      tablet: MediaQuery.of(context).size.height * 0.5,
                      desktop: MediaQuery.of(context).size.height * 0.45,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: _getValidImageUrl(movie.posterUrl, movie.backdropUrl),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[400],
                            child: const Icon(
                              Icons.movie,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.25),
                                Colors.black.withOpacity(0.9),
                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topCenter,
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Watch',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: ResponsiveUtils.getFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'In Theaters ${formatReleaseDate(movie.releaseDate)}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: ResponsiveUtils.getFontSize(context, mobile: 15, tablet: 17, desktop: 19),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                SizedBox(
                                  width: ResponsiveUtils.getResponsiveValue(context, mobile: 260, tablet: 300, desktop: 340),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.lightBlueColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveUtils.getResponsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<BookingProvider>().setMovie(
                                        title: movie.title,
                                        release:
                                            'In Theaters ${formatReleaseDate(movie.releaseDate)}',
                                        releaseD: formatReleaseDate(
                                          movie.releaseDate,
                                        ),
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => const SeatSelectionScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Get Tickets',
                                      style: GoogleFonts.poppins(
                                        fontSize: ResponsiveUtils.getFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                SizedBox(
                                  width: ResponsiveUtils.getResponsiveValue(context, mobile: 260, tablet: 300, desktop: 340),
                                  child: OutlinedButton.icon(
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Watch Trailer',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: ResponsiveUtils.getFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: AppColors.lightBlueColor,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveUtils.getResponsiveValue(context, mobile: 16, tablet: 18, desktop: 20),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: ResponsiveUtils.getScreenPadding(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Genres',
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.getFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Wrap(
                              spacing: 8,
                              children: const [
                                GenreChip('Action', AppColors.cyanColor),
                                GenreChip('Thriller', AppColors.pinkColor),
                                GenreChip('Science', AppColors.purpleColor),
                                GenreChip('Fiction', AppColors.yellowColor),
                              ],
                            ),

                            const SizedBox(height: 16),
                            Divider(color: AppColors.backgroundColor),
                            const SizedBox(height: 16),

                            Text(
                              'Overview',
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.getFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Text(
                              movie.overview,
                              style: GoogleFonts.poppins(
                                fontSize: ResponsiveUtils.getFontSize(context, mobile: 13, tablet: 14, desktop: 15),
                                color: AppColors.subHeadTextColor,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
