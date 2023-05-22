import 'package:count_up_app/get_issues.dart';
import 'package:flutter/material.dart';

class SearchRepositoryScreen extends StatefulWidget {
  const SearchRepositoryScreen({super.key});

  @override
  State<SearchRepositoryScreen> createState() => _SearchRepositoryScreenState();
}

class _SearchRepositoryScreenState extends State<SearchRepositoryScreen> {
  final ownerController = TextEditingController();
  final repositoryController = TextEditingController();
  List<Map<String, dynamic>> issues = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHubリポジトリ情報'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Form(
                      child: TextFormField(
                        controller: ownerController,
                        decoration: const InputDecoration(
                          labelText: 'オーナー名を入力してください',
                        ),
                      ),
                    ),
                    Form(
                      child: TextFormField(
                        controller: repositoryController,
                        decoration: const InputDecoration(
                          labelText: 'リポジトリ名を入力してください',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FloatingActionButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        getIssues(
                          ownerController.text,
                          repositoryController.text,
                        ).then((getIssues) {
                          setState(() {
                            issues = getIssues;
                          });
                        }).catchError((error) {
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('エラー'),
                                content: const Text('リポジトリが見つかりません'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('閉じる'),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      child: const Text('検索'),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(issues[index]['title'] as String),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
