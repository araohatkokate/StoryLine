import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/core/usecase/usecase.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {

  final AuthRespository authRespository;
  const UserSignUp(this.authRespository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRespository.signUpWithEmailPassword(name: params.name, email: params.email, password: params.password);
  }

}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({required this.email, required this.password, required this.name});
}