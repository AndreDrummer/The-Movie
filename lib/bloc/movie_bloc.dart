import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:movie/bloc/bloc.dart';
import 'package:movie/data/cache.dart';
import 'package:movie/utils/constants.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/providers/connection_provider.dart';

class MovieBloc extends Bloc {
  MovieBloc(this._connectionProvider);
  ConnectionProvider _connectionProvider;

  MovieService _movieService = MovieService();

  final _typingSearch = BehaviorSubject<String>.seeded('');
  final _isLoadingMovies = BehaviorSubject<bool>.seeded(false);
  final _movieGenreController = BehaviorSubject<int>.seeded(28);
  final _movieBeingDetailed = BehaviorSubject<MovieDetailsModel>();
  final _movieListController = BehaviorSubject<List<MovieModel>>.seeded([]);

  Stream<String> get typingSearch => _typingSearch.stream;
  Stream<int> get movieGenre => _movieGenreController.stream;
  Stream<bool> get isLoadingMovies => _isLoadingMovies.stream;
  Stream<List<MovieModel>> get movieList => _movieListController.stream;
  Stream<MovieDetailsModel> get movieBeingDetailed => _movieBeingDetailed.stream;

  void changeMovieGenre(int genreID) {
    _movieGenreController.sink.add(genreID);
    _movieListController.sink.add([]);
    loadMovies();
  }

  void Function(String) get changeTypedText => _typingSearch.sink.add;
  void Function(bool) get changeIsLoadingMovies => _isLoadingMovies.sink.add;
  void Function(List<MovieModel>) get changeMovieList => _movieListController.sink.add;
  void Function(MovieDetailsModel) get changeMovieBeingDetailed => _movieBeingDetailed.sink.add;

  String get getTypedText => _typingSearch.value;
  int get getMovieGenre => _movieGenreController.value;
  bool get getIsLoadingMovies => _isLoadingMovies.value;
  List<MovieModel> get getMovieList => _movieListController.value;
  MovieDetailsModel get getMovieBeingDetailed => _movieBeingDetailed.value;

  Future<void> loadMovies() async {
    retrieveListMovie();
    if (getTypedText.isEmpty && _connectionProvider.getIsConnectedStatus) {
      if (getMovieList.isEmpty) changeIsLoadingMovies(true);

      List<MovieModel> movies = await _movieService.getMovieByGenre(getMovieGenre);

      if (getIsLoadingMovies) changeIsLoadingMovies(false);

      changeMovieList(movies);
      cacheListMovie(movies);
    } else {
      await loadMoviesBySearching();
    }
  }

  Future<void> loadMovieDetail(int movieID) async {
    if (_connectionProvider.getIsConnectedStatus) {
      MovieDetailsModel movie = await _movieService.getMovieDetail(movieID);
      changeMovieBeingDetailed(movie);
      cacheMovieDetails(movie);
    }
  }

  Future<void> loadMoviesBySearching() async {
    if (!_connectionProvider.getIsConnectedStatus) {
      changeMovieList([]);
    } else {
      changeIsLoadingMovies(true);
      List<MovieModel> movies = (await _movieService.searchByKeyword(getTypedText.trim())).where((element) => element.genreIds.contains(getMovieGenre)).toList();
      changeMovieList(movies);
      cacheListMovie(movies);
      changeIsLoadingMovies(false);
    }
  }

  void cacheListMovie(List<MovieModel> movies) {
    List<Map<String, dynamic>> cachedData = movies.map((e) => e.toJson()).toList();
    CacheRestApi.saveMap(getMovieGenre.toString(), {CacheKEY.lastMoviesListByGenre.toString(): cachedData});
    CacheRestApi.saveMap(CacheKEY.lastMoviesListLoaded.toString(), {CacheKEY.lastMoviesListLoaded.toString(): cachedData});
  }

  Future<void> cacheMovieDetails(MovieDetailsModel movieDetail) async {
    Map<String, dynamic> storedList = await CacheRestApi.getMap(CacheKEY.movieDetails.toString());

    if (storedList != null) {
      storedList.putIfAbsent(movieDetail.id.toString(), () => json.encode(movieDetail.toJson()));
      CacheRestApi.saveMap(CacheKEY.movieDetails.toString(), storedList);
    } else {
      CacheRestApi.saveMap(CacheKEY.movieDetails.toString(), {
        movieDetail.id.toString(): json.encode(movieDetail.toJson()),
      });
    }
  }

  Future<void> retrieveListMovie() async {
    Map<String, dynamic> mapMovies = await CacheRestApi.getMap(getMovieGenre.toString());
    Map<String, dynamic> lastMoviesLoaded = await CacheRestApi.getMap(CacheKEY.lastMoviesListLoaded.toString());

    if (mapMovies != null) {
      List<MovieModel> movies = List<MovieModel>.from((mapMovies[CacheKEY.lastMoviesListByGenre.toString()] as List).map((movie) => MovieModel.fromJson(movie)));
      changeMovieList(movies);
    } else if (lastMoviesLoaded != null) {
      List<MovieModel> movies = List<MovieModel>();
      movies = (lastMoviesLoaded[CacheKEY.lastMoviesListLoaded.toString()] as List).where((mv) => mv['genre_ids'].contains(getMovieGenre)).map((movie) => MovieModel.fromJson(movie)).toList();
      changeMovieList(movies);
    }
  }

  Future<void> retriveMovieDetails(int movieID) async {
    Map<String, dynamic> storedList = await CacheRestApi.getMap(CacheKEY.movieDetails.toString());

    if (storedList != null) {
      List<int> cachedMovieIds = storedList.keys.map((e) => int.parse(e)).toList();

      if (cachedMovieIds.contains(movieID)) {
        changeMovieBeingDetailed(MovieDetailsModel.fromJson(json.decode(storedList['$movieID'])));
      } else {
        await loadMovieDetail(movieID);
      }
    } else {
      await loadMovieDetail(movieID);
    }
  }

  @override
  void dispose() {
    _typingSearch.close();
    _isLoadingMovies.close();
    _movieBeingDetailed.close();
    _movieListController.close();
    _movieGenreController.close();
  }
}
