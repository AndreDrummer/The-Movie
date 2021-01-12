import 'dart:async';

import 'package:movie/bloc/bloc.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';

class MovieBloc extends Bloc {
  MovieService movieService = MovieService();

  MovieBloc() {
    loadMovies();
    _movieGenreController.sink.add(_movieGenre);
    _movieListController.sink.add(_movieList);
  }

  final _movieListController = StreamController<List<MovieModel>>();
  final _movieGenreController = StreamController<int>();

  int _movieGenre = 28;
  List<MovieModel> _movieList = [];

  Stream<List<MovieModel>> get movieList => _movieListController.stream;
  Stream<int> get movieGenre => _movieGenreController.stream;

  void changeMovieList(List<MovieModel> newMovieList) {
    _movieList = newMovieList;
    _movieListController.sink.add(_movieList);
  }

  void changeMovieGenre(int genreID) {
    _movieGenre = genreID;
    _movieGenreController.sink.add(_movieGenre);
    loadMovies();
  }

  int get getMovieGenre => _movieGenre;
  List<MovieModel> get getMovieList => _movieList;

  Future<void> loadMovies() async {
    _movieListController.sink.add(await movieService.getMovieByGenre(_movieGenre));
  }

  @override
  void dispose() {
    _movieListController.close();
    _movieGenreController.close();
  }
}
