import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_line/core/common/widgets/loader.dart';
import 'package:story_line/core/theme/app_pallete.dart';
import 'package:story_line/core/utils/show_snackbar.dart';
import 'package:story_line/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:story_line/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:story_line/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading) {
            return const Loader();
          }
          if(state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(blog: blog, color: index % 3 == 0 ? AppPallete.gradient1 : index %  3 == 1 ? AppPallete.gradient2 : AppPallete.gradient3);
              },
            );
          } 
          return const SizedBox(); 
        },
      ),
    );
  }
}