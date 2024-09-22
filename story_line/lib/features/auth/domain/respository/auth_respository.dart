import 'package:fpdart/fpdart.dart';
import 'package:story_line/core/error/failures.dart';

abstract interface class AuthRespository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}