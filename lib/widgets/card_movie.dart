import 'package:flutter/material.dart';
import 'package:movie/utils/functions.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    this.onClick,
    this.title = '',
    this.genreIDs = const [],
    @required this.imageUrl,
  });

  final Function onClick;
  final String title;
  final List<int> genreIDs;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    List<String> subTitles = [];
    genreIDs.forEach((element) {
      subTitles.add(CommomFunctions.getGenreByID(element));
    });
    subTitles.removeWhere((element) => element == null);

    return GestureDetector(
      onTap: () => onClick(),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 6.0,
              child: Container(
                width: 320,
                height: 470,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    imageUrl,
                    loadingBuilder: loadingImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 68,
            left: 46,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 14.0),
                ),
                SizedBox(height: 12),
                Row(
                  children: subTitles.map((subtitle) {
                    return Text(
                      subtitle + (subTitles.indexOf(subtitle) < subTitles.length - 1 ? ' - ' : ''),
                      style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white, fontSize: 10.0),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget loadingImage(BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Carregando imagem..'),
          SizedBox(height: 30),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
