import 'package:flutter/material.dart';
import './design/app_colors.dart';
import './widgets/toggle_button.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const countDownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  Timer? timer;
  bool isCountDown = true;

  @override
  void initState() {
    super.initState();
    //startTimer();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void addTime() {
    int addSeconds = isCountDown ? -1 : 1;

    setState(() {
      final int seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    if (timer == null ? true : !timer!.isActive) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors().primary),
                child: Column(children: [
                  buildTime(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleButton(
                        backgroundColor: AppColors().start,
                        text: "Start",
                        interactTimer: startTimer,
                      ),
                      ToggleButton(
                        backgroundColor: AppColors().stop,
                        text: "Stop",
                        interactTimer: stopTimer,
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors().secondary),
                width: double.infinity,
                child: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(fillColor: Colors.white)),
                    TextField(),
                    TextButton(onPressed: () {}, child: Text("Set Timer"))
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    var hours = twoDigits(duration.inHours.remainder(60));
    var minutes = twoDigits(duration.inMinutes.remainder(60));
    var seconds = twoDigits(duration.inSeconds.remainder(60));

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimeCard(time: hours, header: 'HOURS'),
          const SizedBox(width: 20),
          buildTimeCard(time: minutes, header: 'MINUTES'),
          const SizedBox(width: 20),
          buildTimeCard(time: seconds, header: 'SECONDS'),
        ],
      ),
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            padding: EdgeInsets.all(15),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            header,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      );
}
