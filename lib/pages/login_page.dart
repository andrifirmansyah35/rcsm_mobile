import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/login_cubit.dart';
import 'package:mobile_app/models/request/login_body.dart';
import 'package:mobile_app/pages/forgot_password_page.dart';
import 'package:mobile_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginCubit = sl<LoginCubit>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLogin() {
    loginCubit.login(
      LoginBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.off(() => const HomePage());
        }
        if (state is LoginFailed) {
          Get.closeAllSnackbars();
          Get.snackbar(
            'Login Gagal',
            state.message,
            backgroundColor: Theme.of(context).colorScheme.error,
            colorText: Theme.of(context).colorScheme.onError,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  Constants.logoSmallPath,
                  height: 128,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 30),
                Text(
                  'Selamat Datang,',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Member Cantik kami',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                const SizedBox(height: 60),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(
                      FluentIcons.person_16_filled,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(
                      FluentIcons.key_16_filled,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginCubit, LoginState>(
                  bloc: loginCubit,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        onLogin();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: state is LoginLoading
                            ? CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              )
                            : const Text('Masuk'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Lupa password? ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Klik disini',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const ForgotPasswordPage());
                          },
                      ),
                      const TextSpan(text: ' untuk memperbarui password.'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
