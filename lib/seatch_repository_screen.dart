import 'package:flutter/material.dart';

class SearchRepositoryScreen extends StatefulWidget {
  const SearchRepositoryScreen({super.key});

  @override
  State<SearchRepositoryScreen> createState() => _SearchRepositoryScreenState();
}

class _SearchRepositoryScreenState extends State<SearchRepositoryScreen> {
  final ownerController = TextEditingController();
  final repositoryController = TextEditingController();

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
                        final owner = ownerController.text;
                      },
                      child: const Text('検索'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
