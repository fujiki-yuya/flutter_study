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
    GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('編集'),
          content: Form(
            key: editFormKey,
            child: TextFormField(
              controller: editController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'タスクを入力してください';
                } else if (_taskList.contains(value) &&
                    value != _taskList[index]) {
                  return 'このタスクはすでに追加されています。';
                } else {
                  return null;
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (editFormKey.currentState!.validate()) {
                  setState(() {
                    _taskList[index] = editController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('保存'),
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
            ),
          ),

          // ToDoリストを表示する
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                final task = _taskList[index];
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
