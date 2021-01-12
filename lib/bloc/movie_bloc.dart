import 'dart:async';

import 'package:movie/bloc/bloc.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends Bloc {
  MovieService _movieService = MovieService();

  MovieBloc() {
    loadMovies();
  }

  final _typingSearch = BehaviorSubject<String>.seeded('');
  final _movieGenreController = BehaviorSubject<int>.seeded(28);
  final _movieListController = BehaviorSubject<List<MovieModel>>.seeded([]);
  final _movieBeingDetailed = StreamController<MovieDetailsModel>.broadcast();

  Stream<String> get typingSearch => _typingSearch.stream;
  Stream<int> get movieGenre => _movieGenreController.stream;
  Stream<List<MovieModel>> get movieList => _movieListController.stream;
  Stream<MovieDetailsModel> get movieBeingDetailed => _movieBeingDetailed.stream;

  void changeMovieGenre(int genreID) {
    _movieGenreController.sink.add(genreID);
    getTypedText.isEmpty ? loadMovies() : loadMoviesByTyping(getTypedText);
  }

  void Function(String) get changeTypedText => _typingSearch.sink.add;
  void Function(List<MovieModel>) get changeMovieList => _movieListController.sink.add;
  void Function(MovieDetailsModel) get changeMovieBeingDetailed => _movieBeingDetailed.sink.add;

  String get getTypedText => _typingSearch.value;
  int get getMovieGenre => _movieGenreController.value;
  List<MovieModel> get getMovieList => _movieListController.value;

  Future<void> loadMovies() async {
    _movieListController.sink.add(await _movieService.getMovieByGenre(getMovieGenre));
  }

  Future<void> loadMovieDetail(int movieID) async {
    _movieBeingDetailed.sink.add(await _movieService.getMovieDetail(movieID));
  }

  Future<void> loadMoviesByTyping(String typedText) async {
    List<MovieModel> list = (await _movieService.searchByKeyword(typedText)).where((element) => element.genreIds.contains(getMovieGenre)).toList();
    _movieListController.sink.add(list);
  }

  @override
  void dispose() {
    _typingSearch.close();
    _movieBeingDetailed.close();
    _movieListController.close();
    _movieGenreController.close();
  }
}
