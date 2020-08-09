# suspense

A React-like Suspense implementation for Flutter.

## Usage

Awaiting a future with fallback and error widgets:

```dart
class _MyHomePageState extends State<MyHomePage> {
  final _calculation = Future.delayed(
    Duration(seconds: 2),
    () => Random().nextBool() ? 42 : throw 'unknown error',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Suspense<int>(
          future: _calculation,
          fallback: CircularProgressIndicator(),
          builder: (data) => Text('Result: $data'),
          errorBuilder: (error) => Text('Uh oh! it didn\'t work: $error'),
        ),
      ),
    );
  }
}
```

Simple stream example:

```dart
class _MyHomePageState extends State<MyHomePage> {
  final rng = Random();
  Stream<int> _stream;

  @override
  void initState() {
    super.initState();

    _stream = Stream<int>.periodic(
      Duration(seconds: 1),
      (_) => rng.nextInt(10000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Suspense<int>.stream(
          stream: _stream,
          fallback: CircularProgressIndicator(),
          builder: (data) => Text('Result: $data'),
          errorBuilder: (error) => Text('Uh oh! it didn\'t work: $error'),
        ),
      ),
    );
  }
}
```
