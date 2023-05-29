import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api/github_api.dart';

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
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final dio = Dio();
                        final gitHubApi = GitHubApi(dio);
                        final issues = await gitHubApi
                            .searchIssues(
                            'repo:${ownerController.text}/${repositoryController.text} is:issue')
                            .catchError((dynamic e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('issueが取得できません'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        });
                        final pulls = await gitHubApi
                            .getPulls(
                          ownerController.text,
                          repositoryController.text,
                        )
                            .catchError((dynamic e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('issueが取得できません'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        });
                        setState(() {
                          _issues = issues;
                          _pulls = pulls;
                        });
                      },
                      child: const Text('検索'),
                    ),
                  ],
                ),
              ),
              const Text('issue', style: TextStyle(fontSize: 40)),
              Flexible(
                child: ListView.builder(
                  itemCount: _issues?.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    final title = _issues?.items?[index].title;
                    return title != null ? ListTile(
                      title: Text(title),
                    )
                        : const SizedBox.shrink();
                  },
                ),
              ),
              const Text('プルリクエスト', style: TextStyle(fontSize: 40)),
              Flexible(
                child: ListView.builder(
                  itemCount: _pulls.length,
                  itemBuilder: (context, index) {
                    return _pulls[index].title != null
                        ? ListTile(
                      title: Text(_pulls[index].title ?? 'プルリクエストがありません'),
                    )
                        : const SizedBox.shrink();
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
