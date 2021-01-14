import 'package:flutter/material.dart';

class SquaredBadge extends StatelessWidget {
  SquaredBadge({
    this.text2 = '',
    @required this.text,
    this.backgroundColor = const Color(0XFFF1F3F5),
  });

  final String text;
  final String text2;
  final Color backgroundColor;
  final Color borderColor = Color(0XFFF1F3F5);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
        border: Border.all(
          style: BorderStyle.solid,
          color: borderColor,
        ),
      ),
      child: text2.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    text + ': ',
                    style: Theme.of(context).textTheme.headline1.copyWith(color: Color(0XFF868E96), fontSize: 12.0),
                  ),
                  Text(
                    text2,
                    textScaleFactor: text2.length > 30 ? 0.9 : 1,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Color(0XFF343A40),
                          fontSize: text2.length > 30 ? 10 : 12.0,
                        ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
    );
  }
}
