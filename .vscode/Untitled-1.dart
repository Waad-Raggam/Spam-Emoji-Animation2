// to start animation repeat on click of a button
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController? animationController;

  void _initAnimationController() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: RotationTransition(
          alignment: Alignment.center,
          turns: animationController ?? AlwaysStoppedAnimation(0),
          child: Image.asset(
            'assets/images/balloon.png',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create the animation controller when the button is clicked
          _initAnimationController();
          animationController?.repeat();
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    // Make sure to dispose the animation controller properly when the widget is removed from the widget tree.
    animationController?.dispose();
    super.dispose();
  }
}
