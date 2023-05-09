import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => StopwatchScreenState();
}

const SizedBox _spacer = SizedBox(height: 24);

extension _IntZeroPadding on int {
  String get _toStringWithZeroPadding => toString().padLeft(2, '0');
}

class StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  late String _displayTime = _formatTime(const Duration());

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      return;
    }

    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
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
    _stopwatch
      ..stop()
      ..reset();
    _timer.cancel();
    setState(() {
      _displayTime = _formatTime(const Duration());;
    });
  }

  String _formatTime(Duration elapsed) {
    int hundredths = ((elapsed.inMilliseconds / 10).floor() % 100);
    int seconds = elapsed.inSeconds % 60;
    int minutes = elapsed.inMinutes % 60;
    int hours = elapsed.inHours;

    String formattedTime = '${hours._toStringWithZeroPadding}:'
        '${minutes._toStringWithZeroPadding}:'
        '${seconds._toStringWithZeroPadding}:'
        '${hundredths._toStringWithZeroPadding}';

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
                style: const TextStyle(
                    fontSize: 40, fontFeatures: [FontFeature.tabularFigures()]),
              ),
              _spacer,
              ElevatedButton(
                onPressed:
                    //タイマースタート処理
                    _startStopwatch,
                child: const Text('スタート'),
              ),
              _spacer,
              ElevatedButton(
                onPressed:
                    //タイマーストップ処理
                    _stopStopwatch,
                child: const Text('ストップ'),
              ),
              _spacer,
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
