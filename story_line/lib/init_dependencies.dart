import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:story_line/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:story_line/core/network/connection_checker.dart';
import 'package:story_line/core/secrets/app_secrets.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:story_line/features/auth/domain/respository/auth_respository.dart';
import 'package:story_line/features/auth/domain/usecases/current_user.dart';
import 'package:story_line/features/auth/domain/usecases/user_login.dart';
import 'package:story_line/features/auth/domain/usecases/user_sign_up.dart';
import 'package:story_line/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story_line/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:story_line/features/blog/data/respositories/blog_respository_implementation.dart';
import 'package:story_line/features/blog/domain/repositories/blog_respository.dart';
import 'package:story_line/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:story_line/features/blog/domain/usecases/upload_blog.dart';
import 'package:story_line/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies () async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(url: AppSecrets.supabaseurl, anonKey: AppSecrets.supabaseanonkey);
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImplementation(serviceLocator()));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImplementation(serviceLocator()));
  serviceLocator.registerFactory<AuthRespository>(() => AuthRespositoryImplementation(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator())); 
  serviceLocator.registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator(), currentUser: serviceLocator(), appUserCubit: serviceLocator(),));
}

void _initBlog() {
  serviceLocator
  ..registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImplementation(
      serviceLocator(),
      ),
    )
    
    ..registerFactory<BlogRepository>(
      () => BlogRespositoryImplementation(
        serviceLocator(),
        )
      )

    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
        )
      )
    
    ..registerFactory(() => GetAllBlogs(serviceLocator()))

    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
        ),
      );
}