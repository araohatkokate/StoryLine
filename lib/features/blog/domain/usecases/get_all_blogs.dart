import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/core/usecase/usecase.dart';
import 'package:story_line/features/blog/domain/enitities/blog.dart';
import 'package:story_line/features/blog/domain/repositories/blog_respository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }

}