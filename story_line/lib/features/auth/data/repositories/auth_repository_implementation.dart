import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/features/auth/domain/entities/user.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class AuthRespositoryImplementation implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRespositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String password}) 
  async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password,);

      return right(user);
    }

    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  

}