import 'package:movie/utils/constants.dart';

class Endpoints {
  static String getImageMovie(String path) {
    return 'https://image.tmdb.org/t/p/original/$path';
  }

  static String popularMovieList() {
    return 'https://api.themoviedb.org/3/movie/popular?api_key=${Constantes().apiKey}';
  }

  static String searchByKeyword(String keyword, {String language = 'pt-BR', int page = 1}) {
    keyword = keyword.replaceAll(' ', '+');
    return 'https://api.themoviedb.org/3/search/movie?api_key=${Constantes().apiKey}&query=$keyword&language=$language&page=$page';
  }

  static String movieDetail(int movieID, {String language = 'pt-BR'}) {
    return 'https://api.themoviedb.org/3/movie/$movieID?api_key=${Constantes().apiKey}&language=$language&append_to_response=credits';
  }

  static String movieListByGenre(int genreID, {String language = 'pt-BR', int page = 1}) {
    return 'https://api.themoviedb.org/3/discover/movie?api_key=${Constantes().apiKey}&with_genres=$genreID&language=$language&page=$page';
  }
}
