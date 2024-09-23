import 'package:story_line/core/error/exceptions.dart';
import 'package:story_line/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
   Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
   });

   Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
   });
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImplementation(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailPassword({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String name, required String email, required String password}) 
  async{
    try {
      final response = await supabaseClient.auth.signUp(password: password, email: email, data: {'name': name,},
      );

      if(response.user == null)
      {
          throw const ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    }

    catch (e) {
      throw ServerException(e.toString());
    }
  }
  
}