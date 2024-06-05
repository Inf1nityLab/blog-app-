import 'package:blog_app_clean_architecture/core/common/widgets/loader.dart';
import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
import 'package:blog_app_clean_architecture/core/utils/show_snackbar.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/pages/login_page.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/widgets/auth_button_widget.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/widgets/auth_text_button.dart';
import 'package:blog_app_clean_architecture/feature/auth/presentation/widgets/auth_widget.dart';
import 'package:blog_app_clean_architecture/feature/blog/presentation/pages/blog_page.dart';
import 'package:blog_app_clean_architecture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            return showSnackBar(context, state.message);
          }
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BlogPage()),
                    (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoaderWidget();
          }
          //
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign up.',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.whiteColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthWidget(
                    text: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthWidget(
                    text: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthWidget(
                    text: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButtonWidget(
                    text: 'Sign up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const AuthTextButton(
                    text: 'Sign in',
                    screen: LoginPage(),
                  )

                  // AuthButtonWidget(text: 'Sign up', onPressed: (){}),
                  // const SizedBox(height: 15,),
                  // const AuthTextButtonWidget(text: 'Sign in', screen: LoginPage(),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
