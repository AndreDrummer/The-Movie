import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  ButtonBack({
    this.callback,
  });

  final Color textColor = Color(0XFF6D7070);
  final Color buttonColor = Color(0XFFFAFAFA);
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => callback(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 48.0, width / 1.5, 65.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                    size: 12,
                  ),
                  Text(
                    'Voltar',
                    style: Theme.of(context).textTheme.caption.copyWith(color: textColor, fontSize: 12.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
