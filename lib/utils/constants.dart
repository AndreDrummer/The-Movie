import 'package:movie/utils/key_generator.dart';

enum CacheKEY {
  movieDetails,
  lastMoviesListLoaded,
  lastMoviesListByGenre,
}

class Constantes {
  Constantes() {
    apiKey = CesarCripto.decode(encodeArrayKey, 256).toLowerCase();
  }

  List<String> encodeArrayKey = ['Y', 'Y', '23', '3', '1', '0', '22', 'Z', '3', '5', 'Z', '24', 'W', 'A', 'B', 'Z', '25', '23', '24', '4', 'Y', '4', '24', '0', '3', '5', '4', 'A', 'Z', '2', 'W', '22'];
  String apiKey;
}
