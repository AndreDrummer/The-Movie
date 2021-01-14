import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.5,
        ),
        Icon(Icons.wifi_off, size: 100),
        Text(
          'Verifique sua conexão com a internet!',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
