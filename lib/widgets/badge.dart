import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Badge({
    this.id,
    this.onTouch,
    this.title = 'Ação',
    this.selectedGenreID = 28,
  });

  final id;
  final String title;
  final int selectedGenreID;
  final Function onTouch;

  final Color selectedColor = Color(0XFF00384C);
  final Color borderColor = Color(0XFFF1F3F5);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedGenreID == id;

    return GestureDetector(
      onTap: () => onTouch(),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            style: BorderStyle.solid,
            color: isSelected ? selectedColor : borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 12.0, color: isSelected ? Colors.white : selectedColor),
          ),
        ),
      ),
    );
  }
}
