import 'dart:convert';
import 'dart:io';

import 'package:http/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async { 
    final json = await get('https://jsonplaceholder.typicode.com/posts');
    if (json is List) {
      return json.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Ошибка парсинга данных');
    }
  }

  Future<Post> createPost({required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-Type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final  json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
   

    
  }

  Future<dynamic> get(String url) async {
    final uri = Uri.parse(url);
    final request = await client.getUrl(uri);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    return jsonDecode(jsonString);
  }
}
