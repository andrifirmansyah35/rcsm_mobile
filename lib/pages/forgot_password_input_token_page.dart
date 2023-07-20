import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/pages/forgot_password_input_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordInputTokenpage extends StatefulWidget {
  const ForgotPasswordInputTokenpage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordInputTokenpage> createState() =>
      _ForgotPasswordInputTokenpageState();
}

class _ForgotPasswordInputTokenpageState
    extends State<ForgotPasswordInputTokenpage> {
  final tokenController = TextEditingController();

  final tokenNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
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
              text:
                  'Inptukan Token yang telah dikirimkan ke Email kamu. Belum menerima Token? ',
              style: Theme.of(context).textTheme.bodySmall,
              children: <TextSpan>[
                TextSpan(
                  text: 'Klik disini',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Get.to(() => const ForgotPasswordPage());
                    },
                ),
                const TextSpan(text: ' untuk mengirim ulang Token.'),
              ],
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
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const ForgotPasswordInputPage());
              },
              child: const Text('Konfirmasi'),
            ),
          ),
        ],
      ),
    );
  }
}
