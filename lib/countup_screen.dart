import 'package:flutter/material.dart';

class CountUpScreen extends StatefulWidget {
  const CountUpScreen({super.key});

  @override
  State<CountUpScreen> createState() => _CountUpScreenState();
}

class _CountUpScreenState extends State<CountUpScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 100) {
        _counter++;
      } else {
        showDialog<AlertDialog>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('エラー'),
              content: const Text('100が上限です'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('カウントアップ'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
