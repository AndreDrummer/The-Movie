import 'package:flutter/material.dart';

class NoMovieFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 1.75,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/popcorn.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Text(
          'Nenhum filme encontrado!',
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 25),
        ),
      ),
    );
  }
}
