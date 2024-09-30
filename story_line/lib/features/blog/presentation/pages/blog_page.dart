import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_line/features/blog/presentation/pages/add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Line'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, AddNewBlogPage.route());
          }, icon: const Icon(CupertinoIcons.add_circled,))
        ],
      ),
    );
  }
}