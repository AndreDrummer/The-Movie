import 'package:flutter/material.dart';

class NoMovieFound extends StatelessWidget {
  NoMovieFound({
    this.connected = true,
  });
  final bool connected;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/popcorn.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nenhum filme encontrado!',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 25),
            ),
            !connected
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Icon(Icons.wifi_off, color: Colors.red),
                      Text(
                        'Verifique sua conexão com a internet!',
                        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
