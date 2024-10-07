import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/core/network/connection_checker.dart';
import 'package:story_line/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:story_line/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:story_line/features/blog/data/models/blog_model.dart';
import 'package:story_line/features/blog/domain/enitities/blog.dart';
import 'package:story_line/features/blog/domain/repositories/blog_respository.dart';
import 'package:uuid/uuid.dart';

class BlogRespositoryImplementation implements BlogRepository{
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRespositoryImplementation(this.blogRemoteDataSource, this.blogLocalDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image, 
    required String title, 
    required String content, 
    required String posterId, 
    required List<String> topics,
    })  async {
      try{
        if(!await (connectionChecker.isConnected)) {
          return left(Failure('No internet connection!'));
        }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(), 
        posterId: posterId, 
        title: title, 
        content: content, 
        imageUrl: ' ', 
        topics: topics, 
        updatedAt: DateTime.now());

        final imageUrl = await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);

        blogModel = blogModel.copyWith(
          imageUrl: imageUrl,
        );

        final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
        return right(uploadedBlog);
      }

      on ServerException catch (e) {
        return left(Failure(e.toString()));
      }

  }
  
  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if(!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    }

    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
}