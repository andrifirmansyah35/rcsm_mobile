import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/styles.dart';
import 'package:mobile_app/cubit/login_cubit.dart';
import 'package:mobile_app/cubit/service_category_cubit.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = sl<SharedPreferences>();
    final isLogedIn = prefs.containsKey(Constants.keyToken);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => sl<LoginCubit>(),
        ),
        BlocProvider<ServiceCategoryCubit>(
          create: (context) => sl<ServiceCategoryCubit>(),
        ),
      ],
      child: GetMaterialApp(
        title: 'RCSM Mobile',
        theme: ThemeData(
          colorScheme: myColorScheme,
          textTheme: myTextTheme,
        ),
        darkTheme: ThemeData(
          colorScheme: myColorScheme,
          textTheme: myTextTheme,
        ),
        // home: const LoginPage(),
        home: isLogedIn ? const HomePage() : const LoginPage(),
      ),
    );
  }
}
