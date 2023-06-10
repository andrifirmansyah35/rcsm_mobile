import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(
                    FluentIcons.person_16_filled,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(
                    FluentIcons.key_16_filled,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO
                  Get.to(() => const HomePage());
                },
                child: const Text('Masuk'),
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
                          // TODO
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
    );
  }
}
