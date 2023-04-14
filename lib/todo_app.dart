import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  String _taskInput = '';
  final List<String> _taskList = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    //　未入力であればリスト追加できず、追加済みのテキストと同じテキストは追加できない
    if (_taskInput.isNotEmpty && !_taskList.contains(_taskInput)) {
      setState(() {
        _taskList.add(_taskInput);
        _taskInput = '';
        _taskController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _taskList.removeAt(index);
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _taskInput = value;
                      });
                    },
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'タスクを入力してください',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  onPressed: _addTask,
                  child: const Text('追加'),
                ),
              ],
            ),
          ),

          // ToDoリストを表示する
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_taskList[index]),
                  trailing: IconButton(
                    icon: const Text('削除'),
                    onPressed: () => _removeTask(index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
