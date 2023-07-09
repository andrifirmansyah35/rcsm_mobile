import 'package:get_it/get_it.dart';
import 'package:mobile_app/cubit/login_cubit.dart';

final sl = GetIt.instance;

class AppInjector {
  static Future<void> inject() async {
    sl.registerFactory(() => LoginCubit());
  }
}
