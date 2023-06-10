import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_app/common/styles.dart';
import 'package:mobile_app/pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RCSM Mobile',
      theme: ThemeData(
        colorScheme: myColorScheme,
        textTheme: myTextTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: myColorScheme,
        textTheme: myTextTheme,
      ),
      home: const LoginPage(),
    );
  }
}
