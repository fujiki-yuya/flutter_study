import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> getIssues(String owner, String repo) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/repos/$owner/$repo/issues'),
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List<dynamic>)
        .cast<Map<String, dynamic>>();
  } else {
    throw Exception('issueの取得に失敗しました');
  }
}
