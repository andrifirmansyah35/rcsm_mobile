import 'package:get_it/get_it.dart';
import 'package:mobile_app/cubit/add_reservation_cubit.dart';
import 'package:mobile_app/cubit/add_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/add_service_cart_cubit.dart';
import 'package:mobile_app/cubit/delete_closed_service_cubit.dart';
import 'package:mobile_app/cubit/delete_service_cart_cubit.dart';
import 'package:mobile_app/cubit/list_reservation_cubit.dart';
import 'package:mobile_app/cubit/list_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/list_service_cart_cubit.dart';
import 'package:mobile_app/cubit/list_service_cubit.dart';
import 'package:mobile_app/cubit/login_cubit.dart';
import 'package:mobile_app/cubit/schedule_check_cubit.dart';
import 'package:mobile_app/cubit/service_category_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class AppInjector {
  static Future<void> inject() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerFactory<SharedPreferences>(() => sharedPrefs);

    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(() => ServiceCategoryCubit());
    sl.registerFactory(() => ListServiceCubit());
    sl.registerFactory(() => ListServiceCartCubit());
    sl.registerFactory(() => AddServiceCartCubit());
    sl.registerFactory(() => ScheduleCheckCubit());
    sl.registerFactory(() => AddScheduleCartCubit());
    sl.registerFactory(() => ListScheduleCartCubit());
    sl.registerFactory(() => AddReservationCubit());
    sl.registerFactory(() => ListReservationCubit());
    sl.registerFactory(() => DeleteClosedServiceCubit());
    sl.registerFactory(() => DeleteServiceCartCubit());
  }
}
