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
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              'Nenhum filme encontrado!',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 25),
            ),
            !connected
                ? Column(
                    children: [
                      SizedBox(height: 20),
                      Icon(Icons.wifi_off, size: 28),
                      SizedBox(height: 15),
                      Text(
                        'Verifique sua conexão com a internet!',
                        style: Theme.of(context).textTheme.caption,
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
