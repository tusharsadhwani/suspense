library suspense;

import 'package:flutter/material.dart';

class Suspense<T> extends StatelessWidget {
  final Widget fallback;
  final Widget Function(T data) builder;
  final Widget Function(Object error) errorBuilder;

  final Future<T> future;
  final Stream<T> stream;

  const Suspense({
    Key key,
    @required this.future,
    @required this.fallback,
    @required this.builder,
    this.errorBuilder,
  })  : stream = null,
        super(key: key);

  const Suspense.stream({
    Key key,
    @required this.stream,
    @required this.fallback,
    @required this.builder,
    this.errorBuilder,
  })  : future = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (future != null) return buildFuture();
    return buildStream();
  }

  Widget buildFuture() {
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

  Widget buildStream() {
    return StreamBuilder<T>(
      stream: stream,
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
