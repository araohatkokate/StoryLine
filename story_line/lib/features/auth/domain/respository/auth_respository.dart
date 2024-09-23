import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';
import 'package:story_line/features/auth/domain/entities/user.dart';

abstract interface class AuthRespository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}