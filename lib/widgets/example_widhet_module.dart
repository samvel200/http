
import 'package:flutter/material.dart';
import 'package:http/domain/api_clients/api_client.dart';
import 'package:http/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = const <Post>[];
  List<Post> get posts => _posts;


  Future reloadPosts()async{
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }
   Future<void> createPost() async {
    // ignore: unused_local_variable
    final posts =  await apiClient.createPost(
      title: 'ababababa',
       body: 'klir');
   
  }

}

class ExampleModelProvider extends InheritedNotifier {
final ExampleWidgetModel model;

  // ignore: use_super_parameters
  const ExampleModelProvider(
     {
      required this.model,
    Key? key,
   
    required Widget child,
  }) : super(
          key: key,
         notifier: model,
          child: child,
        );

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  }


}