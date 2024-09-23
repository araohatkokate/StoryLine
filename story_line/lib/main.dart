import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_line/core/secrets/app_secrets.dart';
import 'package:story_line/core/theme/theme.dart';
import 'package:story_line/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:story_line/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:story_line/features/auth/domain/usecases/user_sign_up.dart';
import 'package:story_line/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story_line/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseurl,
    anonKey: AppSecrets.supabaseanonkey,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc(userSignUp: UserSignUp(AuthRespositoryImplementation(AuthRemoteDataSourceImplementation(supabase.client,))))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Line',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}


