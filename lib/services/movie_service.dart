import 'package:dio/dio.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/endpoints.dart';

class MovieService {
  Future<List<MovieModel>> getMovieByGenre(int genreID) async {
    List<MovieModel> movies = List<MovieModel>();
    try {
      Response response = await Dio().get(Endpoints.movieListByGenre(genreID));
      if (response.data != null) {
        movies = List<MovieModel>.from(response.data['results'].map((movies) => MovieModel.fromJson(movies)));
      }
    } catch (e) {
      print(e);
    }
    return movies;
  }

  Future<MovieDetailsModel> getMovieDetail(int movieID) async {
    MovieDetailsModel movie = MovieDetailsModel();
    try {
      Response response = await Dio().get(Endpoints.movieDetail(movieID));
      if (response.data != null) {}
      movie = MovieDetailsModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return movie;
  }
}
