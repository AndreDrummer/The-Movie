import 'package:flutter/material.dart';

class BoxSearch extends StatelessWidget {
  BoxSearch({    
    this.onChanged,
    this.hintText,
  });

  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0XFFF1F3F5),
        ),
        child: TextField(          
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 18,
              color: Color(
                0XFF5E6770,
              ),
            ),
            enabledBorder: _textInputBorder(),
            focusedBorder: _textInputBorder(),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.caption,
          ),
          onChanged: (String value) => onChanged(value),
        ),
      ),
    );
  }

  OutlineInputBorder _textInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Color(0XFFF1F3F5),
      ),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
