import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<String> _taskList = [];
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();

  void _addTask() {
    setState(() {
      _taskList.add(_taskController.text);
      _taskController.clear();
    });
  }

  void _removeTask(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
  }

  //　テキストを押すと編集できる
  void _editTask(int index) {
    TextEditingController editController =
        TextEditingController(text: _taskList[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('編集'),
          content: TextFormField(
            controller: editController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 同じタスク名が存在しない場合にのみ、タスクを更新
                if (!_taskList.contains(editController.text)) {
                  setState(() {
                    _taskList[index] = editController.text;
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('このタスクはすでに追加されています'),
                    ),
                  );
                }
              },
              child: const Text('保存'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
          ],
        );
      },
    );
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
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _taskController,
                        decoration: const InputDecoration(
                          labelText: 'タスクを入力してください',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'タスクを入力してください';
                          } else if (_taskList.contains(value)) {
                            return 'このタスクはすでに追加されています。';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addTask();
                        }
                      },
                      child: const Text('追加'),
                    ),
                  ],
                ),
              )),

          // ToDoリストを表示する
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                String task = _taskList[index];
                return ListTile(
                  title: Text(task),
                  onTap: () => _editTask(index),
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
