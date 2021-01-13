import 'package:flutter/material.dart';
import 'package:movie/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  BlocProvider({
    this.key,
    this.bloc,
    this.child,
  }) : super(key: key);

  final T bloc;
  final Key key;
  final Widget child;

  bool updateShouldNotify(_) => true;

  static of<T extends Bloc>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>().bloc;
  }
}
