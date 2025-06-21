import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Map<String, String>>> fetchUserData() async {
    const url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=dc271c4730064ec78f578bafd5d9bb94";
    //print("on the way to get it");
    final response = await http.get(Uri.parse(url));
    //print("on the way to get it"); working

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['articles'];
      //print(results);

      List<Map<String, String>> mappedRecords = [];

      for (var record in results) {
        mappedRecords.add({
          'author': record['author'] != null
              ? record['author'] as String
              : 'Unknown Author',
          'title': record['title'] != null
              ? record['title'] as String
              : 'Untitled',
          'news': record['publishedAt'] != null
              ? record['publishedAt'] as String
              : 'publishedAt not provided',
          'image': record['urlToImage'] != null
              ? record['urlToImage'] as String
              : 'No url provided',
        });
      }
      print(mappedRecords);

      return mappedRecords;
    } else {
      print("Failed to fetch the API data");
      return [];
    }
  }
}
