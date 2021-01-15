import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/widgets/badge.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/utils/debbouncer.dart';
import 'package:movie/widgets/box_search.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/bloc/bloc_provider.dart';
import 'package:movie/services/endpoints.dart';
import 'package:movie/widgets/loading_page.dart';
import 'package:movie/widgets/no_movie_founded.dart';
import 'package:movie/providers/connection_provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _debouncer = Debouncer(milliseconds: 500);
  ConnectionProvider connectionProvider;
  MovieBloc movieBloc;

  @override
  void didChangeDependencies() {
    connectionProvider = Provider.of<ConnectionProvider>(context);
    movieBloc = BlocProvider.of<MovieBloc>(context);
    if (!connectionProvider.getIsConnectedStatus) {
      movieBloc.retrieveListMovie();
    }
    movieBloc.loadMovies();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: RefreshIndicator(
        onRefresh: () async => movieBloc.loadMovies(),
        child: ListView(
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
            StreamBuilder<String>(
              initialData: movieBloc.getTypedText,
              stream: movieBloc.typingSearch,
              builder: (context, snapshot) {
                return BoxSearch(
                  initialValue: snapshot.data,
                  hintText: 'Pesquise filmes',
                  onSubmitted: (_) {
                    if (snapshot.data.trim().isEmpty) movieBloc.loadMovies();
                  },
                  onChanged: (value) {
                    if (value.isEmpty) {
                      movieBloc.changeTypedText(value.trim());
                      movieBloc.loadMovies();
                    } else {
                      movieBloc.changeTypedText(value.trim());
                      if (value.length > 2) _debouncer.run(() => movieBloc.loadMoviesBySearching());
                    }
                  },
                );
              },
            ),
            StreamBuilder<int>(
              stream: movieBloc.movieGenre,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 39.0),
                  child: Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
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
                  ),
                );
              },
            ),
            StreamBuilder<List<MovieModel>>(
              stream: movieBloc.movieList,
              initialData: movieBloc.getMovieList,
              builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
                List<MovieModel> movies = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting || movieBloc.getIsLoadingMovies) {
                  return LoadingPage();
                }

                if (movies.isEmpty) {
                  return NoMovieFound(
                    connected: connectionProvider.getIsConnectedStatus,
                  );
                }

                return Column(
                  children: [
                    StreamBuilder<bool>(
                      initialData: connectionProvider.getIsConnectedStatus,
                      stream: connectionProvider.isConnected,
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshotConnection) {
                        if (!snapshotConnection.data)
                          return Container(
                            padding: const EdgeInsets.only(left: 30, bottom: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Mostrando resultados da última conexão com a internet.',
                              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
                            ),
                          );
                        return Container();
                      },
                    ),
                    ListView.builder(
                      key: UniqueKey(),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardMovie(
                          title: movies[index].title,
                          genreIDs: movies[index].genreIds,
                          imageUrl: Endpoints.getImageMovie(movies[index].posterPath),
                          onClick: () {
                            movieBloc.retriveMovieDetails(movies[index].id);
                            Navigator.pushNamed(context, MovieRouter.MOVIE_DETAIL);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
