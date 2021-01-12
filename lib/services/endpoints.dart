import 'package:movie/utils/constants.dart';

class Endpoints {
  static String get popularMovieList => 'https://api.themoviedb.org/3/movie/popular?api_key=${Constantes.api}';

  static String movieListByGenre(int genreID, {String language = 'pt-BR', int page = 1}) =>
      'https://api.themoviedb.org/3/discover/movie?api_key=${Constantes.api}&with_genres=$genreID&language=$language&page=$page';

  static String getImageMovie(String path) => 'https://image.tmdb.org/t/p/original/$path';
  static String movieDetail(int movieID, {String language = 'pt-BR'}) => 'https://api.themoviedb.org/3/movie/$movieID?api_key=${Constantes.api}&language=$language&append_to_response=credits';

  static String searchByKeyword(String keyword, {String language = 'pt-BR', int page = 1}) {
    keyword = keyword.replaceAll(' ', '+');
    return 'https://api.themoviedb.org/3/search/movie?api_key=${Constantes.api}&query=$keyword&language=$language&page=$page';
  }
}
