import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/core/usecase/usecase.dart';
import 'package:story_line/core/common/entities/user.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRespository authRespository;
  CurrentUser(this.authRespository);

  @override
  Future<Either<Failure, User>> call(NoParams params)  async {
    return await authRespository.currentUser();
  }
}

