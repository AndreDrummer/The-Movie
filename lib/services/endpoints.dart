import 'package:movie/utils/constants.dart';

class Endpoints {
  static String get popularMovieList => 'https://api.themoviedb.org/3/movie/popular?api_key=${Constantes.api}';
  static String movieListByGenre(int genreID) => 'https://api.themoviedb.org/3/discover/movie?api_key=${Constantes.api}&with_genres=$genreID';
}
