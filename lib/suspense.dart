library suspense;

import 'package:flutter/material.dart';

/// Suspense provides a friendly API for using futures in your UI code.
///
/// The most common use case for futures is waiting for an API call to return
/// some data, and then formatting and displaying the received data. While the
/// application is waiting for the API call to respond, the user is typically
/// shown a loading component. Sometimes you also need error-handling from the
/// API response.
/// Suspense provides these as properties, and uses [FutureBuilder] and
/// [StreamBuilder] under the hood for the implementation.
class Suspense<T> extends StatelessWidget {
  /// Generic Future object.
  /// Will be `null` If the `.stream` constructor is used.
  final Future<T> future;

  /// Generic Stream object.
  /// Will be `null` If the regular constructor is used.
  final Stream<T> stream;

  /// The Widget to be returned if no data has yet been received from the future
  /// or stream.
  final Widget fallback;

  /// Builder method for the widget once the Future or Stream returns data.
  final Widget Function(T data) builder;

  /// Builder method for the widget if the Future or Stream throws an error.
  final Widget Function(Object error) errorBuilder;

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
