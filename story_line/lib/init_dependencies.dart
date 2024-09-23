import 'package:get_it/get_it.dart';
import 'package:story_line/core/secrets/app_secrets.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';
import 'package:story_line/features/auth/domain/usecases/user_sign_up.dart';
import 'package:story_line/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies () async {
  _initAuth();
  final supabase = await Supabase.initialize(url: AppSecrets.supabaseurl, anonKey: AppSecrets.supabaseanonkey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImplementation(serviceLocator()));
  serviceLocator.registerFactory<AuthRespository>(() => AuthRespositoryImplementation(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator(),));
}