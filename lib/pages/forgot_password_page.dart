import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/send_token_cubit.dart';
import 'package:mobile_app/pages/forgot_password_input_token_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final sendTokenCubit = sl<SendTokenCubit>();
  final emailController = TextEditingController();

  void onSendToken() {
    sendTokenCubit.fetchData(emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendTokenCubit, SendTokenState>(
      bloc: sendTokenCubit,
      listener: (context, state) {
        if (state is SendTokenSuccess) {
          Get.to(() => const ForgotPasswordInputTokenpage());
        }

        if (state is SendTokenFailed) {
          Get.snackbar(
            'Gagal',
            state.message,
            backgroundColor: Theme.of(context).colorScheme.error,
            colorText: Theme.of(context).colorScheme.primary,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  Image.asset(
                    Constants.logoSmallPath,
                    height: 128,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 60),
                  Text(
                    'Lupa Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Masukkan Email yang terhubung dengan akun kamu.\nKode token yang dapat digunakan untuk menganti password anda akan dikirimkan ke Email kamu',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      suffixIcon: Icon(
                        FluentIcons.person_16_filled,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is SendTokenLoading ? null : onSendToken,
                    child: state is SendTokenLoading
                        ? const Padding(
                            padding: EdgeInsets.all(5),
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Kirim Token'),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
