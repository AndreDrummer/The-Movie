import 'package:flutter/material.dart';
import 'package:movie/bloc/bloc_provider.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/services/endpoints.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/widgets/badge.dart';
import 'package:movie/widgets/box_search.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/widgets/loading_page.dart';
import 'package:movie/widgets/no_movie_founded.dart';

class MovieList extends StatelessWidget {
  final MovieBloc movieBloc = MovieBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      bloc: movieBloc,
      child: Scaffold(
        body: Column(
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
            StreamBuilder<int>(
              stream: movieBloc.movieGenre,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 37.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Badge(
                        title: 'Ação',
                        id: 28,
                        selectedGenreID: snapshot.data,
                        onTouch: () => movieBloc.changeMovieGenre(28),
                      ),
                      Badge(
                        title: 'Aventura',
                        id: 12,
                        selectedGenreID: snapshot.data,
                        onTouch: () => movieBloc.changeMovieGenre(12),
                      ),
                      Badge(
                        title: 'Fantasia',
                        id: 14,
                        selectedGenreID: snapshot.data,
                        onTouch: () => movieBloc.changeMovieGenre(14),
                      ),
                      Badge(
                        title: 'Comédia',
                        id: 35,
                        selectedGenreID: snapshot.data,
                        onTouch: () => movieBloc.changeMovieGenre(35),
                      ),
                    ],
                  ),
                );
              },
            ),
            StreamBuilder<List<MovieModel>>(
              stream: movieBloc.movieList,
              builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
                List<MovieModel> movies = snapshot.data;
                print(movies);

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }

                if (movies.isEmpty) {
                  return NoMovieFound();
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardMovie(
                        title: movies[index].title,
                        genreIDs: movies[index].genreIds,
                        imageUrl: Endpoints.getImageMovie(movies[index].backdropPath),
                        onClick: () {
                          Navigator.pushNamed(context, MovieRouter.MOVIE_DETAIL, arguments: movies[index]);
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}