import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _counter = 0;
  late ShakeDetector detector;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
     detector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.5,
        onPhoneShake: (){
     setState(() {
      _counter ++;
     });
    });
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  WidgetsBinding.instance.removeObserver(this);

  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container().box.red500.size(20, 20).make(),
              '흔들어서 카운트를 올려보세요!'.text.size(20).make(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
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


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        detector.startListening();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        detector.stopListening();
        break;
      case AppLifecycleState.detached:
        break;
    }

  }
  }
