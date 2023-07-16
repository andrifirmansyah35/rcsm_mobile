import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/pages/change_password_page.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:mobile_app/pages/reservation_page.dart';
import 'package:mobile_app/pages/schedule_cart_page.dart';
import 'package:mobile_app/pages/schedule_check_page.dart';
import 'package:mobile_app/pages/service_cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = sl<SharedPreferences>();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    Constants.logoSmallPath,
                    width: 60,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          prefs.getString(Constants.keyMemberName) ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          prefs.getString(Constants.keyMemberEmail) ?? '',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ChangePasswordPage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: const Icon(Icons.settings),
                    label: const Text('Ganti Password'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ReservationPage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(Icons.aod_sharp),
                    label: const Text('Reservasi'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ScheduleCheckPage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Cek Jadwal'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ServiceCartPage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: const Icon(FluentIcons.cut_20_regular),
                    label: const Text('Keranjang Layanan'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ScheduleCartPage());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    icon: const Icon(FluentIcons.clock_16_regular),
                    label: const Text('Keranjang Jadwal Operasi'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      prefs.clear();
                      Get.offAll(() => const LoginPage());
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    icon: const Icon(FluentIcons.sign_out_20_filled),
                    label: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
