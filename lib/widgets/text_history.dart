import 'package:flutter/material.dart';

class TextHistory extends StatelessWidget {
  TextHistory({
    this.bodyText,
    this.title,
  });

  final String title;
  final String bodyText;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
            child: Text(title, style: Theme.of(context).textTheme.caption),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
            child: Text(
              bodyText,
              style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 12.0),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
