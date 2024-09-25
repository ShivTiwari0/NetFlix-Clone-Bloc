import 'package:quadb/data/model/movie_model.dart';

abstract class MovieState{
  final List<MovieModel>? movies;

  MovieState(this.movies);
}

class MovieInitialState extends MovieState{
  MovieInitialState() : super([]);
}
class MovieLoadingState extends MovieState{
  MovieLoadingState(super.movies) ;
}
class MovieLoaddedState extends MovieState{
  MovieLoaddedState(super.movies) ;
}

class MovieErrorState extends MovieState{
  final String? message;
  MovieErrorState(super.movies, this.message) ;
}