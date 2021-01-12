import 'package:flutter/material.dart';
import 'package:movie/widgets/button_back.dart';
import 'package:movie/widgets/card_movie.dart';
import 'package:movie/widgets/squared_badge.dart';
import 'package:movie/widgets/text_history.dart';
import 'package:movie/widgets/text_rating.dart';

class MovieDetail extends StatelessWidget {
  final Color titleColor = Color(0XFF343A40);
  final Color subTitleColor = Color(0XFF5E6770);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ButtonBack(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 72.0),
          //   child: Container(
          //     height: 318,
          //     width: 216,
          //     child: CardMovie(),
          //   ),
          // ),
          SizedBox(height: 32.0),
          TextRating(),
          SizedBox(height: 32.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              'CAPITÃ MARVEL',
              style: Theme.of(context).textTheme.headline1.copyWith(color: titleColor),
            ),
          ),
          SizedBox(height: 12.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Título Original: Capitain Marvel',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10, color: subTitleColor),
            ),
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquaredBadge(
                text: 'Ano',
                text2: '2019',
              ),
              SquaredBadge(
                text: 'Duração',
                text2: '1h 20 min',
              ),
            ],
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquaredBadge(
                backgroundColor: Theme.of(context).canvasColor,
                text: 'AÇÃO',
              ),
              SquaredBadge(
                backgroundColor: Theme.of(context).canvasColor,
                text: 'AVENTURA',
              ),
              SquaredBadge(
                backgroundColor: Theme.of(context).canvasColor,
                text: 'SCI-FI',
              ),
            ],
          ),
          SizedBox(height: 63.0),
          TextHistory(
            title: 'DESCRIÇÃO',
            bodyText:
                'Aventura sobre Carol Danvers, uma agente da CIA que tem contato com uma raça alienígena e ganha poderes sobre-humanos. Entre os seus poderes estão uma força fora do comum e a habilidade de voar.',
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SquaredBadge(
              text: 'ORÇAMENTO',
              text2: '\$ 152,000,000',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SquaredBadge(
              text: 'PRODUTORAS',
              text2: 'Marvel Studios',
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
      ),
    );
  }
}
