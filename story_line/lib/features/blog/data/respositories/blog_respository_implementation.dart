import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:story_line/features/blog/data/models/blog_model.dart';
import 'package:story_line/features/blog/domain/enitities/blog.dart';
import 'package:story_line/features/blog/domain/repositories/blog_respository.dart';
import 'package:uuid/uuid.dart';

class BlogRespositoryImplementation implements BlogRepository{
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRespositoryImplementation(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image, 
    required String title, 
    required String content, 
    required String posterId, 
    required List<String> topics,
    })  async {
      try{
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(), 
        posterId: posterId, 
        title: title, 
        content: content, 
        imageUrl: ' ', 
        topics: topics, 
        updatedAt: DateTime.now());

        final imageUrl = await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);

        blogModel = blogModel.copywith(
          imageUrl: imageUrl,
        );

        final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
        return right(uploadedBlog);
      }

      on ServerException catch (e) {
        return left(Failure(e.toString()));
      }

  }
  
}