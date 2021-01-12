import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Carregando...', style: Theme.of(context).textTheme.caption),
        SizedBox(height: 15),
        CircularProgressIndicator(),
      ],
    );
  }
}
