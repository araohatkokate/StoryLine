import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class AuthRespositoryImplementation implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRespositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({required String name, required String email, required String password}) 
  async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password,);

      return right(userId);
    }

    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  

}