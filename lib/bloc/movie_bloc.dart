import 'dart:async';

import 'package:movie/bloc/bloc.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';

class MovieBloc extends Bloc {
  MovieService _movieService = MovieService();

  MovieBloc() {
    loadMovies();
    _movieListController.sink.add(_movieList);
    _movieGenreController.sink.add(_movieGenre);
  }

  final _movieGenreController = StreamController<int>();
  final _movieBeingDetailed = StreamController<MovieDetailsModel>.broadcast();
  final _movieListController = StreamController<List<MovieModel>>();
  final _typingSearch = StreamController<String>();

  int _movieGenre = 28;
  List<MovieModel> _movieList = [];
  String _typedText = '';

  Stream<int> get movieGenre => _movieGenreController.stream;
  Stream<List<MovieModel>> get movieList => _movieListController.stream;
  Stream<MovieDetailsModel> get movieBeingDetailed => _movieBeingDetailed.stream;
  Stream<String> get typingSearch => _typingSearch.stream;

  void Function(MovieDetailsModel) get changeMovieBeingDetailed => _movieBeingDetailed.sink.add;

  void changeMovieGenre(int genreID, {bool searchTypedText = false}) {
    _movieGenre = genreID;
    _movieGenreController.sink.add(_movieGenre);
    searchTypedText ? loadMovies() : loadMoviesByTyping(_typedText);
  }

  void changeMovieList(List<MovieModel> newMovieList) {
    _movieList = newMovieList;
    _movieListController.sink.add(_movieList);
  }

  void changeTypedText(String text) {
    _typedText = text;
    _typingSearch.sink.add(_typedText);
  }

  int get getMovieGenre => _movieGenre;
  String get getTypedText => _typedText;
  List<MovieModel> get getMovieList => _movieList;

  Future<void> loadMovies() async {
    _movieListController.sink.add(await _movieService.getMovieByGenre(_movieGenre));
  }

  Future<void> loadMovieDetail(int movieID) async {
    _movieBeingDetailed.sink.add(await _movieService.getMovieDetail(movieID));
  }

  Future<void> loadMoviesByTyping(String typedText) async {
    List<MovieModel> list = (await _movieService.searchByKeyword(typedText)).where((element) => element.genreIds.contains(_movieGenre)).toList();
    _movieListController.sink.add(list);
  }

  @override
  void dispose() {
    _movieBeingDetailed.close();
    _movieListController.close();
    _movieGenreController.close();
    _typingSearch.close();
  }
}
