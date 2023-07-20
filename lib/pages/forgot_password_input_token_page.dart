import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/check_token_cubit.dart';
import 'package:mobile_app/pages/forgot_password_input_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordInputTokenpage extends StatefulWidget {
  const ForgotPasswordInputTokenpage({
    required this.email,
    Key? key,
  }) : super(key: key);

  final String email;

  @override
  State<ForgotPasswordInputTokenpage> createState() =>
      _ForgotPasswordInputTokenpageState();
}

class _ForgotPasswordInputTokenpageState
    extends State<ForgotPasswordInputTokenpage> {
  final checkTokenCubit = sl<CheckTokenCubit>();

  final tokenController = TextEditingController();

  final tokenNotifier = ValueNotifier<String?>(null);

  void onCheckToken() {
    checkTokenCubit.fetchData(tokenController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckTokenCubit, CheckTokenState>(
          bloc: checkTokenCubit,
          listener: (context, state) {
            if (state is CheckTokenSuccess) {
              Get.off(
                () => ForgotPasswordInputPage(
                  email: widget.email,
                  token: tokenController.text,
                ),
              );
            }
            if (state is CheckTokenFailed) {
              Get.snackbar(
                'Gagal',
                state.message,
                backgroundColor: Theme.of(context).colorScheme.error,
                colorText: Theme.of(context).colorScheme.primary,
              );
            }
          },
        )
      ],
      child: Scaffold(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                Constants.logoSmallPath,
                height: 128,
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Verifikasi Token',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 21,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Inputkan Token yang telah dikirimkan ke Email kamu. ',
                style: Theme.of(context).textTheme.bodySmall,
                // children: <TextSpan>[
                //   const TextSpan(text: 'Belum menerima Token? '),
                //   TextSpan(
                //     text: 'Klik disini',
                //     style: const TextStyle(fontWeight: FontWeight.bold),
                //     recognizer: TapGestureRecognizer()
                //       ..onTap = () {
                //         // Get.to(() => const ForgotPasswordPage());
                //       },
                //   ),
                //   const TextSpan(text: ' untuk mengirim ulang Token.'),
                // ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(15),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Theme.of(context).colorScheme.background,
                  selectedFillColor: Theme.of(context).colorScheme.background,
                  inactiveFillColor: Theme.of(context).colorScheme.onPrimary,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: tokenController,
                onCompleted: (v) {
                  //
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  log(value);
                  tokenNotifier.value = value;
                  if (value.length == 6) {
                    setState(() {});
                  }
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
            ),
            BlocBuilder<CheckTokenCubit, CheckTokenState>(
              bloc: checkTokenCubit,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: state is CheckTokenLoading ||
                            tokenController.text.length != 6
                        ? null
                        : onCheckToken,
                    child: state is CheckTokenLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Konfirmasi'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
