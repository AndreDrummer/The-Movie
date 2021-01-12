import 'package:flutter/material.dart';
import 'package:movie/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  BlocProvider({
    this.bloc,
    this.child,
    this.key,
  }) : super(key: key);

  final Widget child;
  final T bloc;
  final Key key;

  bool updateShouldNotify(_) => true;

  static of<T extends Bloc>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>().bloc;
  }
}
