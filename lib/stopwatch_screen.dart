import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => StopwatchScreenState();
}

class StopwatchScreenState extends State<StopwatchScreen> {
  final _stopWatchTimer = StopWatchTimer();

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
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snapshot) {
                  final displayTime =
                      StopWatchTimer.getDisplayTime(snapshot.data!);
                  return Text(
                    displayTime,
                    style: const TextStyle(fontSize: 64),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  //タイマースタート処理
                  _stopWatchTimer.onStartTimer();
                },
                child: const Text('スタート'),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  //タイマーストップ処理
                  _stopWatchTimer.onStopTimer();
                },
                child: const Text('ストップ'),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  //タイマーリセット処理
                  _stopWatchTimer.onResetTimer();
                },
                child: const Text('リセット'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
