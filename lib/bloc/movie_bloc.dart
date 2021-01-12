import 'dart:async';

import 'package:movie/bloc/bloc.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';

class MovieBloc extends Bloc {
  MovieService movieService = MovieService();

  MovieBloc() {
    loadMovies();
    _movieListController.sink.add(_movieList);
    _movieGenreController.sink.add(_movieGenre);
  }

  final _movieGenreController = StreamController<int>();
  final _movieBeingDetailed = StreamController<MovieDetailsModel>.broadcast();
  final _movieListController = StreamController<List<MovieModel>>();

  int _movieGenre = 28;
  List<MovieModel> _movieList = [];

  Stream<int> get movieGenre => _movieGenreController.stream;
  Stream<List<MovieModel>> get movieList => _movieListController.stream;
  Stream<MovieDetailsModel> get movieBeingDetailed => _movieBeingDetailed.stream;

  void Function(MovieDetailsModel) get changeMovieBeingDetailed => _movieBeingDetailed.sink.add;

  void changeMovieGenre(int genreID) {
    _movieGenre = genreID;
    _movieGenreController.sink.add(_movieGenre);
    loadMovies();
  }

  void changeMovieList(List<MovieModel> newMovieList) {
    _movieList = newMovieList;
    _movieListController.sink.add(_movieList);
  }

  int get getMovieGenre => _movieGenre;
  List<MovieModel> get getMovieList => _movieList;

  Future<void> loadMovies() async {
    _movieListController.sink.add(await movieService.getMovieByGenre(_movieGenre));
  }

  Future<void> loadMovieDetail(int movieID) async {
    _movieBeingDetailed.sink.add(await movieService.getMovieDetail(movieID));
  }

  @override
  void dispose() {
    _movieBeingDetailed.close();
    _movieListController.close();
    _movieGenreController.close();
  }
}
