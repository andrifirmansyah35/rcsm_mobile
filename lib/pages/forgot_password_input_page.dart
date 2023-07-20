import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/request_new_password_cubit.dart';
import 'package:mobile_app/models/request/request_new_password_body.dart';
import 'package:mobile_app/pages/login_page.dart';

class ForgotPasswordInputPage extends StatefulWidget {
  const ForgotPasswordInputPage({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);

  final String email;
  final String token;

  @override
  State<ForgotPasswordInputPage> createState() =>
      _ForgotPasswordInputPageState();
}

class _ForgotPasswordInputPageState extends State<ForgotPasswordInputPage> {
  final _formKey = GlobalKey<FormState>();

  final requestNewPasswordCubit = sl<RequestNewPasswordCubit>();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  void onChangePassword() {
    if (_formKey.currentState!.validate()) {
      requestNewPasswordCubit.fetchData(
        RequestNewPasswordBody(
          email: widget.email,
          token: widget.token,
          passwordBaru: passConfirmController.text,
        ),
      );
    }
  }

  String? passValidation(String? value) {
    if (passController.text != passConfirmController.text) {
      return 'Password harus sama';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestNewPasswordCubit, RequestNewPasswordState>(
      bloc: requestNewPasswordCubit,
      listener: (context, state) {
        if (state is RequestNewPasswordSuccess) {
          Get.snackbar(
            'Berhasil',
            state.response.message,
            backgroundColor: Theme.of(context).colorScheme.background,
            colorText: Theme.of(context).colorScheme.primary,
          );
          Get.offAll(() => const LoginPage());
        }

        if (state is RequestNewPasswordFailed) {
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      Constants.logoSmallPath,
                      height: 128,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Lupa Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Masukkan Token yang didapat di email kamu dan password baru kamu',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(
                          FluentIcons.person_16_filled,
                        ),
                      ),
                      enabled: false,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                        labelText: 'Password Baru',
                        suffixIcon: const Icon(
                          FluentIcons.key_16_filled,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      obscureText: true,
                      validator: passValidation,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passConfirmController,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password Baru',
                        suffixIcon: const Icon(
                          FluentIcons.key_reset_20_filled,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      obscureText: true,
                      validator: passValidation,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state is RequestNewPasswordLoading
                          ? null
                          : onChangePassword,
                      child: state is RequestNewPasswordLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Ubah Password'),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
