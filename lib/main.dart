import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Traffic light',
//         home: Scaffold(
//             appBar: AppBar(
//                 title: Text('Traffic light'),
//                 backgroundColor: Colors.teal[300]),
//             body: Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text(
//                       'GO',
//                       style: TextStyle(fontSize: 32, color: Colors.green[500]),
//                     ),
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                       Icon(Icons.circle, size: 100, color: Colors.green[500]),
//                       Icon(Icons.circle, size: 100, color: Colors.orange[100]),
//                       Icon(Icons.circle, size: 100, color: Colors.red[100]),
//                     ])
//                   ]),
//             )));
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String light = 'GREEN';
  String instruction = 'GO';
  Color? instructionColor = Colors.green[500];

  bool run = false;
  String btnDisplayTxt = "Start";

  int _counter = 10;
  Timer? _timer;

  @override
  void initState() {
    light = 'GREEN';
    instruction = 'GO';
    instructionColor = Colors.green[500];
    _counter = 5;
    super.initState();
  }

  void timer() {
    if (!run)
      _startTimer();
    else
      _stopTimer();
    run = !run;
    btnDisplayTxt = run ? "Stop" : "Start";
  }

  int turnOnLight(String lightactive) {
    int num = 100;

    if (light == lightactive) {
      num = 500;
    }
    return num;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          if (light == 'GREEN') {
            light = 'YELLOW';
            instruction = 'SLOW';
            instructionColor = Colors.orange[500];
            _counter = 3;
          } else if (light == 'YELLOW') {
            light = 'RED';
            instruction = 'STOP';
            instructionColor = Colors.red[500];
            _counter = 5;
          } else {
            light = 'GREEN';
            instruction = 'GO';
            instructionColor = Colors.green[500];
            _counter = 5;
          }
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      light = 'GREEN';
      instruction = 'GO';
      instructionColor = Colors.green[500];
      _counter = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Traffic light',
        home: Scaffold(
            appBar: AppBar(
                title: Text('Traffic light'),
                backgroundColor: Colors.teal[300]),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      instruction,
                      style: TextStyle(fontSize: 40, color: instructionColor),
                    ),
                    Text(
                      _counter.toString(),
                      style: TextStyle(fontSize: 40, color: instructionColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 60,
                            color: Colors.green[turnOnLight('GREEN')]),
                        Icon(Icons.circle,
                            size: 60,
                            color: Colors.orange[turnOnLight('YELLOW')]),
                        Icon(Icons.circle,
                            size: 60, color: Colors.red[turnOnLight('RED')]),
                      ],
                    ),
                    ElevatedButton(onPressed: timer, child: Text(btnDisplayTxt))
                  ]),
            )));
  }
}
