import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/core/common/entities/user.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';

class AuthRespositoryImplementation implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRespositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    }

    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({required String email, required String password}) 
  async {
    return _getUser(()  async => await remoteDataSource.loginWithEmailPassword(email: email, password: password),);
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String password}) 
  async {
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(name: name, email: email, password: password));
  }
  
  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    }

    on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
}