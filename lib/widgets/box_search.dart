import 'package:flutter/material.dart';

class BoxSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Color(0XFFF1F3F5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 14.0, 161.0, 16.0),
        child: Row(
          children: [
            Container(
              // width: 14,
              // height: 14,
              child: Icon(
                Icons.search,
                size: 18,
                color: Color(
                  0XFF5E6770,
                ),
              ),
            ),
            SizedBox(width: 17.34),
            Text(
              'Pesquise Filmes',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
