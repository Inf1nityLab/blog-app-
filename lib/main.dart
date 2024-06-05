import 'package:blog_app_clean_architecture/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app_clean_architecture/core/theme/theme.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/pages/login_page.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/pages/sign_up_pages.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/pages/add_blog_page.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/pages/blog_page.dart';
import 'package:blog_app_clean_architecture/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AuthLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const SignUpPage();
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Map<String, dynamic> person = {
    'name': 'baias'
  };
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Success'),
      ),
    );
  }
}
