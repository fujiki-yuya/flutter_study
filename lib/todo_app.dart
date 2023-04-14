import 'dart:ffi';

import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  String _taskInput = '';
  final List<String> _taskList = [];

  void _addTask() {
    setState(() {
      _taskList.add(_taskInput);
      _taskInput = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoアプリ'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _taskInput = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'タスクを入力してください',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
