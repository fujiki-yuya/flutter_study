import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => StopwatchScreenState();
}

const SizedBox spacer = SizedBox(height: 24);

class StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _displayTime = "00:00:00:00";

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      return;
    }

    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        _displayTime =
            _formatTime(Duration(milliseconds: _stopwatch.elapsedMilliseconds));
      });
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer.cancel();
    setState(() {
      _displayTime = "00:00:00:00";
    });
  }

  String _formatTime(Duration elapsed) {
    int hundredths = ((elapsed.inMilliseconds / 10).floor() % 100);
    int seconds = elapsed.inSeconds % 60;
    int minutes = elapsed.inMinutes % 60;
    int hours = elapsed.inHours;

    String formattedTime = '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}:'
        '${hundredths.toString().padLeft(2, '0')}';

    return formattedTime;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ストップウォッチ'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _displayTime,
                style: const TextStyle(fontSize: 40),
              ),
              spacer,
              ElevatedButton(
                onPressed:
                    //タイマースタート処理
                    _startStopwatch,
                child: const Text('スタート'),
              ),
              spacer,
              ElevatedButton(
                onPressed:
                    //タイマーストップ処理
                    _stopStopwatch,
                child: const Text('ストップ'),
              ),
              spacer,
              ElevatedButton(
                onPressed:
                    //タイマーリセット処理
                    _resetStopwatch,
                child: const Text('リセット'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
