import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/styles.dart';
import 'package:mobile_app/cubit/add_reservation_cubit.dart';
import 'package:mobile_app/cubit/add_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/add_service_cart_cubit.dart';
import 'package:mobile_app/cubit/change_password_cubit.dart';
import 'package:mobile_app/cubit/check_token_cubit.dart';
import 'package:mobile_app/cubit/delete_closed_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/delete_closed_service_cubit.dart';
import 'package:mobile_app/cubit/delete_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/delete_service_cart_cubit.dart';
import 'package:mobile_app/cubit/list_reservation_cubit.dart';
import 'package:mobile_app/cubit/list_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/list_service_cart_cubit.dart';
import 'package:mobile_app/cubit/list_service_cubit.dart';
import 'package:mobile_app/cubit/login_cubit.dart';
import 'package:mobile_app/cubit/request_new_password_cubit.dart';
import 'package:mobile_app/cubit/schedule_check_cubit.dart';
import 'package:mobile_app/cubit/send_token_cubit.dart';
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
        BlocProvider<ListServiceCubit>(
          create: (context) => sl<ListServiceCubit>(),
        ),
        BlocProvider<ListServiceCartCubit>(
          create: (context) => sl<ListServiceCartCubit>(),
        ),
        BlocProvider<AddServiceCartCubit>(
          create: (context) => sl<AddServiceCartCubit>(),
        ),
        BlocProvider<ScheduleCheckCubit>(
          create: (context) => sl<ScheduleCheckCubit>(),
        ),
        BlocProvider<AddScheduleCartCubit>(
          create: (context) => sl<AddScheduleCartCubit>(),
        ),
        BlocProvider<ListScheduleCartCubit>(
          create: (context) => sl<ListScheduleCartCubit>(),
        ),
        BlocProvider<AddReservationCubit>(
          create: (context) => sl<AddReservationCubit>(),
        ),
        BlocProvider<ListReservationCubit>(
          create: (context) => sl<ListReservationCubit>(),
        ),
        BlocProvider<DeleteClosedServiceCubit>(
          create: (context) => sl<DeleteClosedServiceCubit>(),
        ),
        BlocProvider<DeleteServiceCartCubit>(
          create: (context) => sl<DeleteServiceCartCubit>(),
        ),
        BlocProvider<DeleteClosedScheduleCartCubit>(
          create: (context) => sl<DeleteClosedScheduleCartCubit>(),
        ),
        BlocProvider<DeleteScheduleCartCubit>(
          create: (context) => sl<DeleteScheduleCartCubit>(),
        ),
        BlocProvider<ChangePasswordCubit>(
          create: (context) => sl<ChangePasswordCubit>(),
        ),
        BlocProvider<SendTokenCubit>(
          create: (context) => sl<SendTokenCubit>(),
        ),
        BlocProvider<CheckTokenCubit>(
          create: (context) => sl<CheckTokenCubit>(),
        ),
        BlocProvider<RequestNewPasswordCubit>(
          create: (context) => sl<RequestNewPasswordCubit>(),
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
