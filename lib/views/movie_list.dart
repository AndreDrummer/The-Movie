import 'package:flutter/material.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/widgets/badge.dart';
import 'package:movie/widgets/box_search.dart';
import 'package:movie/widgets/card_movie.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 48.0, 278.0, 24.0),
            child: Container(
              child: Text(
                'Filmes',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          // Deve ser capaz de guardar o texto digitado e fazer pesqusia na API.
          BoxSearch(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 43.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Devem efeturar açaõ ao serem tocados. Ex.: Buscat lista de filmes pela categoria selecionada
                Badge(isSelected: true, title: 'Ação'),
                Badge(isSelected: false, title: 'Aventura'),
                Badge(isSelected: false, title: 'Fantasia'),
                Badge(isSelected: false, title: 'Comédia'),
              ],
            ),
          ),
          // Deve ser uma lista de card movies
          CardMovie(
            onClick: () {
              Navigator.pushNamed(context, MovieRouter.MOVIE_DETAIL);
            },
          )
        ],
      ),
    );
  }
}
