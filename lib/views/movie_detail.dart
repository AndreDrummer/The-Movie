import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/utils/functions.dart';
import 'package:movie/bloc/bloc_provider.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/services/endpoints.dart';
import 'package:movie/widgets/button_back.dart';
import 'package:movie/widgets/text_rating.dart';
import 'package:movie/widgets/loading_page.dart';
import 'package:movie/widgets/text_history.dart';
import 'package:movie/widgets/squared_badge.dart';
import 'package:movie/widgets/no_connection.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/providers/connection_provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class MovieDetail extends StatelessWidget {
  final Color titleColor = Color(0XFF343A40);
  final Color subTitleColor = Color(0XFF5E6770);

  @override
  Widget build(BuildContext context) {
    final MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);
    final ConnectionProvider connectionProvider = Provider.of<ConnectionProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          ButtonBack(
            callback: () {
              movieBloc.changeMovieBeingDetailed(null);
              Navigator.maybePop(context);
            },
          ),
          StreamBuilder<Object>(
            initialData: connectionProvider.getIsConnectedStatus,
            stream: connectionProvider.isConnected,
            builder: (context, snapshotConnection) {
              if (!snapshotConnection.data && movieBloc.getMovieBeingDetailed == null) {
                return NoConnection();
              }
              return Column(
                children: [
                  StreamBuilder<MovieDetailsModel>(
                    stream: movieBloc.movieBeingDetailed,
                    builder: (context, snapshotMovieDetail) {
                      if (snapshotMovieDetail.connectionState == ConnectionState.waiting || snapshotMovieDetail.data == null) {
                        return LoadingPage(
                          textLoading: 'Carregando detalhes do filme...',
                        );
                      }

                      MovieDetailsModel movie = snapshotMovieDetail.data;
                      String produtoras = movie == null ? '' : movie.productionCompanies.map((e) => e.name).toList().toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ', \n');
                      String elenco = movie == null ? '' : movie.credits.cast.where((element) => element.popularity > 10).map((e) => e.name).toList().toString().replaceAll('[', '').replaceAll(']', '');
                      String director = '';
                      String budget = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', initialValue: movie != null ? movie.budget / 1 : 0.0).text;

                      List crewList = movie == null ? [] : movie.credits.crew.where((element) => element.job == 'Director').toList();
                      if (crewList.isNotEmpty) director = crewList.first.name;

                      return ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 62),
                            child: CardMovie(
                              height: 318,
                              width: 216,
                              imageUrl: Endpoints.getImageMovie(movie?.posterPath),
                            ),
                          ),
                          SizedBox(height: 32.0),
                          TextRating(
                            rating: movie == null ? '' : movie.voteAverage.toString(),
                          ),
                          SizedBox(height: 32.0),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            child: Text(
                              movie == null ? '' : movie.title.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1.copyWith(color: titleColor),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Título Original: ',
                                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10, color: subTitleColor),
                                ),
                                Text(
                                  movie == null ? '' : '${movie.originalTitle}',
                                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10, color: subTitleColor, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SquaredBadge(
                                text: 'Ano',
                                text2: movie == null ? '' : '${movie.releaseDate.split('-').first}',
                              ),
                              SquaredBadge(
                                text: 'Duração',
                                text2: movie == null ? '' : '${CommomFunctions.formatClock(movie.runtime)}',
                              ),
                            ],
                          ),
                          SizedBox(height: 18.0),
                          Container(
                            alignment: Alignment.center,
                            height: 45,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: movie == null
                                  ? []
                                  : movie.genres
                                      .map(
                                        (genre) => SquaredBadge(backgroundColor: Theme.of(context).canvasColor, text: genre.name.toUpperCase()),
                                      )
                                      .toList(),
                            ),
                          ),
                          SizedBox(height: 63.0),
                          TextHistory(title: 'Descrição', bodyText: movie == null ? '' : movie.overview),
                          SizedBox(height: 40.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SquaredBadge(
                              text: 'ORÇAMENTO',
                              text2: movie == null ? '' : '${movie.budget == 0 ? '-' : '\$ $budget'}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SquaredBadge(
                              text: 'PRODUTORAS',
                              text2: produtoras,
                            ),
                          ),
                          SizedBox(height: 40.0),
                          TextHistory(
                            title: 'Diretor',
                            bodyText: director.isEmpty ? '-' : director,
                          ),
                          SizedBox(height: 32.0),
                          TextHistory(
                            title: 'Elenco',
                            bodyText: elenco.isEmpty ? '-' : elenco,
                          ),
                          SizedBox(height: 90.0),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
