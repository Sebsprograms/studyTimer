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
  static const countDownDuration = Duration(minutes: 9);
  Duration duration = const Duration();
  Timer? timer;
  bool isCountDown = true;

  final hourController = TextEditingController();
  final minutesController = TextEditingController();
  final secondsController = TextEditingController();

  double _currentSliderValue = 5;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void setTime() {
    if (hourController.text.isEmpty ||
        minutesController.text.isEmpty ||
        secondsController.text.isEmpty) return;

    final enteredHours = int.parse(hourController.text);
    final enteredMinutes = int.parse(minutesController.text);
    final enteredSeconds = int.parse(secondsController.text);

    if (enteredHours < 0 || enteredMinutes < 0 || enteredSeconds < 0) return;
    setState(() => duration = Duration(
          hours: enteredHours,
          minutes: enteredMinutes,
          seconds: enteredSeconds,
        ));
  }

  void clearTimer() {
    setState(() => duration = const Duration(
          hours: 0,
          minutes: 0,
          seconds: 0,
        ));
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
      timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
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
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
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
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blueGrey),
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
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors().secondary),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Hours"),
                            keyboardType: TextInputType.number,
                            controller: hourController,
                            onSubmitted: (_) => setTime(),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 100,
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Minutes"),
                            keyboardType: TextInputType.number,
                            controller: minutesController,
                            onSubmitted: (_) => setTime(),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 100,
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Seconds"),
                            keyboardType: TextInputType.number,
                            controller: secondsController,
                            onSubmitted: (_) => setTime(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Study Amount",
                      style: TextStyle(fontSize: 18),
                    ),
                    buildSlider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setTime();
                            },
                            child: const Text("Set Timer")),
                        TextButton(
                            onPressed: () {
                              clearTimer();
                            },
                            child: const Text("Reset Timer")),
                      ],
                    )
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
      margin: const EdgeInsets.all(10),
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

  Widget buildSlider() => Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 10,
      label: "${_currentSliderValue.round().toString()}%",
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      });

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            padding: const EdgeInsets.all(15),
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
