import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api/github_api.dart';
import 'model/issue_result.dart';
import 'model/pull.dart';

class SearchRepositoryScreen extends StatefulWidget {
  const SearchRepositoryScreen({super.key});

  @override
  State<SearchRepositoryScreen> createState() => _SearchRepositoryScreenState();
}

class _SearchRepositoryScreenState extends State<SearchRepositoryScreen> {
  final ownerController = TextEditingController();
  final repositoryController = TextEditingController();
  IssueResult? _issues;
  List<Pull> _pulls = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    ownerController.dispose();
    repositoryController.dispose();
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ownerController,
                        decoration: const InputDecoration(
                          labelText: 'オーナー名を入力してください',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'オーナー名を入力してください';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: repositoryController,
                        decoration: const InputDecoration(
                          labelText: 'リポジトリ名を入力してください',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'リポジトリ名を入力してください';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            final dio = Dio();
                            final gitHubApi = GitHubApi(dio);

                            await Future.wait([
                              gitHubApi.searchIssues(
                                'repo:${ownerController.text}/${repositoryController.text} is:issue',
                              ),
                              gitHubApi.getPulls(
                                ownerController.text,
                                repositoryController.text,
                              ),
                            ]).then(
                              (apiResult) {
                                setState(() {
                                  _issues = apiResult[0] as IssueResult?;
                                  _pulls = apiResult[1] as List<Pull>;
                                });
                              },
                              onError: (dynamic e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('リポジトリ情報が取得できません: $e'),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: const Text('検索'),
                      ),
                    ],
                  ),
                ),
              ),
              const Text('issue', style: TextStyle(fontSize: 40)),
              Flexible(
                child: ColoredBox(
                  color: Colors.red,
                  child: ListView.builder(
                    itemCount: _issues?.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      final title = _issues?.items?[index].title;
                      return title != null
                          ? ListTile(
                              title: Text(title),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              const Text('プルリクエスト', style: TextStyle(fontSize: 40)),
              Flexible(
                child: ColoredBox(
                  color: Colors.blue,
                  child: ListView.builder(
                    itemCount: _pulls.length,
                    itemBuilder: (context, index) {
                      return _pulls[index].title != null
                          ? ListTile(
                              title:
                                  Text(_pulls[index].title ?? 'プルリクエストがありません'),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
