import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({
    this.textLoading = 'Carregando...',
  });

  final String textLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.5,
          ),
          Text(textLoading, style: Theme.of(context).textTheme.caption),
          SizedBox(height: 15),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
