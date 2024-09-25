import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb/data/model/movie_model.dart';
import 'package:quadb/data/repository/movie_repository.dart';
import 'package:quadb/logic/cubit/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitialState()) {
    _initialize();
  }

  final movieRepository = MovieRepository();

  void _initialize() async {
    emit(MovieLoadingState(state.movies));
    try {
      List<MovieModel> movies = await movieRepository.fetchAllMovies();
      emit(MovieLoaddedState(movies));
    } catch (e) {
      emit(MovieErrorState([], e.toString())); // Ensure to pass an empty list on error
    }
  }

  void searchMovies(String query) {
    final currentState = state;
    if (currentState is MovieLoaddedState) {
      // Check if current movies are not null before filtering
      List<MovieModel> searchedMovies = currentState.movies != null
          ? currentState.movies!
              .where((movie) => movie.name!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : [];
      emit(MovieLoaddedState(searchedMovies)); // Emit the updated state with searched movies
    }
  }
}
