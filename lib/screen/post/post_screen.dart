import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_23/controller/post_controller.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super. key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen', style: TextStyle(color: Colors.black26)),
      ),
      body: Center(
        child: Text(
          'Welcome to the Post Screen!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
