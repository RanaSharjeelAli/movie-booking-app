import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_demo_project/config/app_assets.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/movie_list_provider.dart';
import '../config/app_theme.dart';
import '../widget/movie_card_widget.dart';
import 'movie_detail_screen.dart';
import 'search_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieListProvider>().loadUpcomingMovies();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<MovieListProvider>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.background,
        titleSpacing: 16,
        centerTitle: false,
        title: Text(
          'Watch',
          style: GoogleFonts.poppins(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AppImages.icSearch,
              color: AppColors.textColor,
              height: 20,
              width: 20,
            ),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
          ),
        ],
      ),
      body: Consumer<MovieListProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.upcomingMovies.isEmpty) {
            return const MovieListLoadingShimmer();
          }

          if (provider.errorMessage != null &&
              provider.upcomingMovies.isEmpty) {
            return MovieErrorWidget(
              message: provider.errorMessage!,
              onRetry: () {
                context.read<MovieListProvider>().loadUpcomingMovies(
                  forceRefresh: true,
                );
              },
            );
          }

          if (provider.upcomingMovies.isEmpty) {
            return const EmptyMoviesList();
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<MovieListProvider>().loadUpcomingMovies(
                forceRefresh: true,
              );
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              itemCount: provider.upcomingMovies.length + 1,
              itemBuilder: (context, index) {
                if (index == provider.upcomingMovies.length) {
                  return provider.isLoading
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.md),
                          child: CircularProgressIndicator(),
                        ),
                      )
                      : const SizedBox.shrink();
                }

                final movie = provider.upcomingMovies[index];
                return MovieCardWidget(
                  movie: movie,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movieId: movie.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
