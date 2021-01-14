import 'package:flutter/material.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/providers/connection_provider.dart';
import 'package:movie/utils/functions.dart';
import 'package:movie/bloc/bloc_provider.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/services/endpoints.dart';
import 'package:movie/widgets/button_back.dart';
import 'package:movie/widgets/no_connection.dart';
import 'package:movie/widgets/text_rating.dart';
import 'package:movie/widgets/loading_page.dart';
import 'package:movie/widgets/text_history.dart';
import 'package:movie/widgets/squared_badge.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatelessWidget {
  final Color titleColor = Color(0XFF343A40);
  final Color subTitleColor = Color(0XFF5E6770);

  @override
  Widget build(BuildContext context) {
    final MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);
    final ConnectionProvider connectionProvider = Provider.of<ConnectionProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          ButtonBack(),
          StreamBuilder<Object>(
            initialData: connectionProvider.getIsConnectedStatus,
            stream: connectionProvider.isConnected,
            builder: (context, snapshotConnection) {
              if (!snapshotConnection.data) {
                return NoConnection();
              }
              return Column(
                children: [
                  StreamBuilder<MovieDetailsModel>(
                    stream: movieBloc.movieBeingDetailed,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            SizedBox(height: height / 3),
                            LoadingPage(
                              textLoading: 'Carregando detalhes do filme...',
                            ),
                          ],
                        );
                      }

                      MovieDetailsModel movie = snapshot.data;
                      String produtoras = movie.productionCompanies.map((e) => e.name).toList().toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ', \n');
                      String elenco = movie.credits.cast.where((element) => element.popularity > 10).map((e) => e.name).toList().toString().replaceAll('[', '').replaceAll(']', '');
                      String director = '';
                      String budget = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', initialValue: movie.budget / 1).text;

                      List crewList = movie.credits.crew.where((element) => element.job == 'Director').toList();
                      if (crewList.isNotEmpty) director = crewList.first.name;

                      return ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 72.0),
                            child: Container(
                              height: 318,
                              width: 216,
                              child: CardMovie(
                                imageUrl: Endpoints.getImageMovie(movie.backdropPath),
                              ),
                            ),
                          ),
                          SizedBox(height: 32.0),
                          TextRating(
                            rating: movie.voteAverage.toString(),
                          ),
                          SizedBox(height: 32.0),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              movie.title.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1.copyWith(color: titleColor),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Título Original: ${movie.originalTitle}',
                              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10, color: subTitleColor),
                            ),
                          ),
                          SizedBox(height: 32.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SquaredBadge(
                                text: 'Ano',
                                text2: '${movie.releaseDate.split('-').first}',
                              ),
                              SquaredBadge(
                                text: 'Duração',
                                text2: '${CommomFunctions.formatClock(movie.runtime)}',
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
                              children: movie.genres
                                  .map(
                                    (genre) => SquaredBadge(backgroundColor: Theme.of(context).canvasColor, text: genre.name.toUpperCase()),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 63.0),
                          TextHistory(title: 'DESCRIÇÃO', bodyText: movie.overview),
                          SizedBox(height: 40.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SquaredBadge(
                              text: 'ORÇAMENTO',
                              text2: '${movie.budget == 0 ? '-' : '\$ $budget'}',
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
