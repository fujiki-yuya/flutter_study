import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getIssues(String owner, String repository) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/repos/$owner/$repository/issues'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception('issueの取得に失敗しました');
  }
}
