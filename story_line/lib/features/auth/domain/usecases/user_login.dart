import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/core/usecase/usecase.dart';
import 'package:story_line/features/auth/domain/entities/user.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRespository authRespository;
  const UserLogin(this.authRespository);
  
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRespository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}