import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/movie_list_provider.dart';
import '../config/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widget/final_result_widget.dart';
import '../widget/search_bar_widget.dart';
import '../widget/search_movie_card_widget.dart';
import '../widget/top_result_list_widget.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool submitted = false;
  bool isTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieListProvider>();

    final movies =
        provider.lastSearchQuery == null || provider.lastSearchQuery!.isEmpty
            ? provider.upcomingMovies
            : provider.searchResults;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,

      appBar:
          submitted
              ? AppBar(
                backgroundColor: AppColors.white,
                surfaceTintColor: AppColors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    submitted = false;
                    isTyping = false;
                    _controller.clear();
                    provider.clearSearch();
                    setState(() {});
                  },
                ),
                centerTitle: false,
                titleSpacing: 0,

                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '${provider.searchResults.length} Results Found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              : AppBar(
                backgroundColor: AppColors.white,
                surfaceTintColor: AppColors.white,
                elevation: 0,
                toolbarHeight: 100,
                automaticallyImplyLeading: false,
                leading:
                    submitted
                        ? IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            submitted = false;
                            isTyping = false;
                            _controller.clear();
                            provider.clearSearch();
                            setState(() {});
                          },
                        )
                        : null,
                centerTitle: false,
                title: SearchBarField(
                  controller: _controller,
                  onChanged: (value) {
                    isTyping = value.isNotEmpty;
                    submitted = false;

                    if (value.isEmpty) {
                      provider.clearSearch();
                    } else {
                      provider.searchMovies(value);
                    }
                    setState(() {});
                  },

                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      submitted = true;
                      isTyping = false;
                      provider.searchMovies(value);

                      FocusScope.of(context).unfocus();
                      setState(() {});
                    }
                  },
                  onClear: () {
                    _controller.clear();
                    isTyping = false;
                    submitted = false;
                    provider.clearSearch();
                    setState(() {});
                  },
                ),
              ),

      body:
          provider.isSearching
              ? const Center(child: CircularProgressIndicator())
              : submitted
              ? FinalResultsList(
                  movies: provider.searchResults,
                  onTap: (movie) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movieId: movie.id),
                      ),
                    );
                  },
                )
              : isTyping
              ? TopResultsList(
                  movies: provider.searchResults.take(5).toList(),
                  onTap: (movie) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movieId: movie.id),
                      ),
                    );
                  },
                )
              : GridView.builder(
                padding: ResponsiveUtils.getScreenPadding(context),
                itemCount: movies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(context),
                  mainAxisSpacing: ResponsiveUtils.getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
                  crossAxisSpacing: ResponsiveUtils.getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
                  childAspectRatio: ResponsiveUtils.getAspectRatio(context),
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return SearchMovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(movieId: movie.id),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
