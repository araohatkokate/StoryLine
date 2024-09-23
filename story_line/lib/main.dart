import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_line/core/theme/theme.dart';
import 'package:story_line/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story_line/features/auth/presentation/pages/login_page.dart';
import 'package:story_line/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>(),),
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


