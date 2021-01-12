import 'package:flutter/material.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    this.onClick,
    this.title = '',
    this.subTitles = const [''],
    @required this.imageUrl,
  });

  final Function onClick;
  final String title;
  final List<String> subTitles;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: AssetImage('assets/movie_placeholder.png'),
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 14.0),
                ),
                SizedBox(height: 12),
                Row(
                  children: subTitles
                      .map(
                        (subtitle) => Text(
                          subtitle,
                          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white, fontSize: 10.0),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
