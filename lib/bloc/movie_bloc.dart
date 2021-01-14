import 'dart:async';
import 'package:movie/data/cache.dart';
import 'package:movie/providers/connection_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:movie/bloc/bloc.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/movie_service.dart';
import 'package:movie/models/movie_details_model.dart';

class MovieBloc extends Bloc {
  MovieBloc(this._connectionProvider);

  ConnectionProvider _connectionProvider;
  MovieService _movieService = MovieService();
  CacheRestApi cacheRestApi = CacheRestApi();

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
    loadMovies();
  }

  void Function(String) get changeTypedText => _typingSearch.sink.add;
  void Function(List<MovieModel>) get changeMovieList => _movieListController.sink.add;
  void Function(MovieDetailsModel) get changeMovieBeingDetailed => _movieBeingDetailed.sink.add;

  String get getTypedText => _typingSearch.value;
  int get getMovieGenre => _movieGenreController.value;
  List<MovieModel> get getMovieList => _movieListController.value;

  Future<void> loadMovies() async {
    if (!_connectionProvider.getIsConnectedStatus) {
      retrieveDataFromCache();
    } else if (getTypedText.isEmpty) {
      print('Call loading Movies');
      List<MovieModel> movies = await _movieService.getMovieByGenre(getMovieGenre);
      _movieListController.sink.add(movies);
      cacheData(movies);
    } else {
      loadMoviesByTyping();
    }
  }

  Future<void> loadMovieDetail(int movieID) async {
    _movieBeingDetailed.sink.add(await _movieService.getMovieDetail(movieID));
  }

  Future<void> loadMoviesByTyping() async {
    if (!_connectionProvider.getIsConnectedStatus) {
      retrieveDataFromCache();
    } else
      print('Call loading Movies Typed');
    List<MovieModel> movies = (await _movieService.searchByKeyword(getTypedText)).where((element) => element.genreIds.contains(getMovieGenre)).toList();
    _movieListController.sink.add(movies);
    cacheData(movies);
  }

  Future<void> retrieveDataFromCache() async {
    Map<String, dynamic> mapMovies = await CacheRestApi.getMap(getMovieGenre.toString());
    if (mapMovies != null) {
      List<MovieModel> movies = List<MovieModel>.from((mapMovies['lastMovieList'] as List).map((movie) => MovieModel.fromJson(movie)));
      print(movies.length);
      _movieListController.sink.add(movies);
    } else {
      _movieListController.sink.add([]);
    }
  }

  void cacheData(List<MovieModel> movies) {
    List<Map<String, dynamic>> cachedData = movies.map((e) => e.toJson()).toList();
    CacheRestApi.saveMap(getMovieGenre.toString(), {'lastMovieList': cachedData});
  }

  @override
  void dispose() {
    _typingSearch.close();
    _movieBeingDetailed.close();
    _movieListController.close();
    _movieGenreController.close();
  }
}
