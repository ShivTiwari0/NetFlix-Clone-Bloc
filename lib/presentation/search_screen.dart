import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb/data/model/movie_model.dart';
import 'package:quadb/logic/cubit/movie_cubit.dart';
import 'package:quadb/logic/cubit/movie_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String query, MovieCubit movieCubit) {
    // Call the Cubit method to get the searched movie data.
    movieCubit.searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CupertinoSearchTextField(
                controller: searchController,
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
                onSuffixTap: () {
                  searchController.clear();
                  context.read<MovieCubit>().searchMovies('');
                },
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  search(value, context.read<MovieCubit>());
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaddedState) {
                    final movies = state.movies;

                    if (searchController.text.isEmpty) {
                      return _buildTopSearches(movies ?? []);
                    } else {
                      final searchedMovies = movies?.where((movie) =>
                          movie.name!.toLowerCase().contains(searchController.text.toLowerCase())).toList() ?? [];
                      
                      if (searchedMovies.isEmpty) {
                        return const Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return _buildSearchResults(searchedMovies);
                    }
                  } else if (state is MovieErrorState) {
                    return Center(
                      child: Text(
                        state.message ?? "An error occurred",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSearches(List<MovieModel> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Top Searches",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length, // Show all movies as top searches
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CachedNetworkImage(imageUrl: 
                  movies[index].image?.medium ?? 'https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 90,
                ),
                title: Text(
                  movies[index].name ?? "Unknown",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                 
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults(List<MovieModel> searchedMovies) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchedMovies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2 / 2,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigate to movie details (implement the navigation)
              },
              child: Image.network(
                searchedMovies[index].image?.medium ?? "",
                fit: BoxFit.cover,
                height: 170,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searchedMovies[index].name ?? "Unknown",
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
