import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    this.onClick,
    this.showTitle = true,
  });

  final Function onClick;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        width: 320,
        height: 470,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/marvel.jpg'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: showTitle
            ? Padding(
                padding: const EdgeInsets.only(left: 44.0, bottom: 56.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CAPITÃ MARVEL',
                      style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 14.0),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Ação',
                          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white, fontSize: 10.0),
                        ),
                        Text(
                          ' Aventura',
                          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Text(''),
      ),
    );
  }
}
