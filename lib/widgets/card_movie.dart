import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/utils/functions.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    this.onClick,
    this.title = '',
    this.genreIDs = const [],
    @required this.imageUrl,
    this.height = 470,
    this.width = 320,
  });

  final Function onClick;
  final String title;
  final List<int> genreIDs;
  final String imageUrl;
  final double width;
  final double height;

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
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 6.0,
              child: Container(
                width: width,
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: placeholderImage,
                    fit: BoxFit.cover,
                    errorWidget: errorWidget,
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

  Widget placeholderImage(BuildContext context, String text) {
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

  Widget errorWidget(BuildContext context, String url, dynamic error) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/movie_placeholder.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height / 1.6),
          Icon(Icons.error),
          SizedBox(height: 15),
          Text(
            'Não foi possível carregar imagem!',
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
