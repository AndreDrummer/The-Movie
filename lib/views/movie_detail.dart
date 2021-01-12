import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/models/movie_details_model.dart';
import 'package:movie/services/endpoints.dart';
import 'package:movie/utils/functions.dart';
import 'package:movie/widgets/button_back.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/widgets/loading_page.dart';
import 'package:movie/widgets/squared_badge.dart';
import 'package:movie/widgets/text_history.dart';
import 'package:movie/widgets/text_rating.dart';

class MovieDetail extends StatelessWidget {
  final Color titleColor = Color(0XFF343A40);
  final Color subTitleColor = Color(0XFF5E6770);

  @override
  Widget build(BuildContext context) {
    final MovieBloc movieBloc = MovieBloc();

    return Scaffold(
      body: StreamBuilder<MovieDetailsModel>(
          stream: movieBloc.movieBeingDetailed,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            }

            MovieDetailsModel movie = snapshot.data;

            return ListView(
              children: [
                ButtonBack(),
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
                TextRating(),
                SizedBox(height: 32.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    movie.title.toUpperCase(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: movie.genres
                      .map(
                        (genre) => SquaredBadge(backgroundColor: Theme.of(context).canvasColor, text: genre.name.toUpperCase()),
                      )
                      .toList(),
                ),
                SizedBox(height: 63.0),
                TextHistory(title: 'DESCRIÇÃO', bodyText: movie.overview),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SquaredBadge(
                    text: 'ORÇAMENTO',
                    text2: '\$ ${MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', initialValue: movie.budget / 1)}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SquaredBadge(
                    text: 'PRODUTORAS',
                    text2: movie.productionCompanies.map((e) => e.name).toList().toString(),
                  ),
                ),
                SizedBox(height: 40.0),
                TextHistory(
                  title: 'Diretor',
                  bodyText: 'Ryan Fleck, Anna Boden',
                ),
                SizedBox(height: 32.0),
                TextHistory(
                  title: 'Elenco',
                  bodyText: 'Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace',
                ),
                SizedBox(height: 90.0),
              ],
            );
          }),
    );
  }
}
