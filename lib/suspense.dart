library suspense;

import 'package:flutter/material.dart';

class Suspense<T> extends StatelessWidget {
  final Future<T> future;
  final Widget fallback;
  final Widget Function(T data) builder;
  final Widget Function(Object error) errorBuilder;

  const Suspense({
    Key key,
    @required this.future,
    @required this.fallback,
    @required this.builder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data);
        } else if (snapshot.hasError) {
          return (errorBuilder != null)
              ? errorBuilder(snapshot.error)
              : Text('Error: ${snapshot.error}');
        } else {
          return fallback;
        }
      },
    );
  }
}
