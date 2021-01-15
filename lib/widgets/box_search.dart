import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxSearch extends StatefulWidget {
  BoxSearch({
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
  });

  final String hintText;
  final String initialValue;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  _BoxSearchState createState() => _BoxSearchState();
}

class _BoxSearchState extends State<BoxSearch> {
  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text = widget.initialValue;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0XFFF1F3F5),
        ),
        child: TextFormField(
          controller: _controller,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.go,
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
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.caption,
          ),
          onFieldSubmitted: (String value) => widget.onSubmitted(value),
          onChanged: (String value) => widget.onChanged(value),
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
