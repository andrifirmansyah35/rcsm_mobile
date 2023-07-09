import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_app/app/app.dart';
import 'package:mobile_app/app/app_injector.dart';

Future<void> main() async {
  bootstrap(App.new);
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting();

      await AppInjector.inject();

      runApp(await builder());

      // //* Firebase Performance
      // FirebasePerformance.instance;

      // //* Firebase Analytics
      // FirebaseAnalytics.instance;

      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    },
    (error, stackTrace) async {
      log(error.toString(), stackTrace: stackTrace);
      // await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
