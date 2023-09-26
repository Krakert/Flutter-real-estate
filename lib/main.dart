import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: AppTypography.title01,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

abstract class AppTypography {

  static const title01 = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const title02 = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const title03 = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const body = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const input = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const hint = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const subtitle = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );

  static const detail = TextStyle(
    fontFamily: "Gotham SSm",
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
}