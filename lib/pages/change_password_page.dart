import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/cubit/change_password_cubit.dart';
import 'package:mobile_app/models/request/change_password_body.dart';
import 'package:mobile_app/pages/home_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final changePasswordCubit = sl<ChangePasswordCubit>();
  final _formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmController = TextEditingController();

  void onChangePassword() {
    if (_formKey.currentState!.validate()) {
      if (newPasswordController.text != newPasswordConfirmController.text) {
        Get.snackbar(
          'Gagal',
          'Password Baru Konfirmasi tidak sama',
          backgroundColor: Theme.of(context).colorScheme.error,
          colorText: Theme.of(context).colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        changePasswordCubit.fetchData(
          ChangePasswordBody(
            passwordLama: oldPasswordController.text,
            passwordBaru: newPasswordConfirmController.text,
          ),
        );
      }
    }
  }

  String? customValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wajib diisi';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      bloc: changePasswordCubit,
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          Get.snackbar(
            'Berhasil',
            state.response.message,
            backgroundColor: Theme.of(context).colorScheme.background,
            colorText: Theme.of(context).colorScheme.primary,
          );
          Get.offAll(const HomePage());
        }

        if (state is ChangePasswordFailed) {
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
            title: const Text('Ubah Password'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: oldPasswordController,
                      validator: customValidator,
                      decoration: InputDecoration(
                        labelText: 'Password Lama',
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: newPasswordController,
                      validator: customValidator,
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: newPasswordConfirmController,
                      validator: customValidator,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password Baru',
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
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state is ChangePasswordLoading
                          ? null
                          : onChangePassword,
                      child: state is ChangePasswordLoading
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Ubah Password'),
                    ),
                    const SizedBox(height: 10),
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
