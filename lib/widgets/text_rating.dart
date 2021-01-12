import 'package:flutter/material.dart';

class TextRating extends StatelessWidget {
  TextRating({
    this.rating,
  });
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rating,
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24.0, color: Color(0XFF00384C)),
        ),
        Text(
          '/ 10',
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 14.0, color: Color(0XFF868E96)),
        ),
      ],
    );
  }
}
