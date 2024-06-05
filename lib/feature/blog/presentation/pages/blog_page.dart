import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.add, color: AppPallete.backgroundColor,),
        title: const Text('Blog app'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddBlogPag()));
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.whiteColor,
              ))
        ],
      ),
    );
  }
}
