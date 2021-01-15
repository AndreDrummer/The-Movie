import 'package:flutter/material.dart';
import 'package:movie/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardMovie extends StatelessWidget {
  CardMovie({
    this.onClick,
    this.title = '',
    this.width = 320,
    this.height = 470,
    @required this.imageUrl,
    this.genreIDs = const [],
  });

  final String title;
  final double width;
  final double height;
  final String imageUrl;
  final Function onClick;
  final List<int> genreIDs;

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
            bottom: 20,
            left: 24,
            child: Container(
              alignment: Alignment.bottomLeft,
              width: width + 24,
              height: height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.8),
                  end: Alignment(0.0, 0.0),
                  colors: [
                    Color.fromRGBO(0, 0, 0, 1),
                    Color.fromRGBO(0, 0, 0, 0.6331),
                    Color.fromRGBO(0, 0, 0, 0.01),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
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
                    SizedBox(height: 32),
                  ],
                ),
              ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Icon(Icons.error, color: Colors.grey[400]),
          SizedBox(height: 15),
          Text(
            'Não foi possível carregar imagem!',
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
