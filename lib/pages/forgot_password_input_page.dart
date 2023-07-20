import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
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
      body: SingleChildScrollView(
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
                decoration: const InputDecoration(
                  labelText: 'Token',
                  suffixIcon: Icon(
                    FluentIcons.password_16_filled,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password Baru',
                  suffixIcon: Icon(
                    FluentIcons.key_16_filled,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                  suffixIcon: Icon(
                    FluentIcons.key_reset_20_filled,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const LoginPage());
                },
                child: const Text('Ubah Password'),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
