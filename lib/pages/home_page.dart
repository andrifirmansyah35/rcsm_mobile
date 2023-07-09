import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/pages/detail_service_category_page.dart';
import 'package:mobile_app/pages/reservation_page.dart';
import 'package:mobile_app/pages/schedule_check_page.dart';
import 'package:mobile_app/pages/service_category_page.dart';
import 'package:mobile_app/widgets/custom_drawer.dart';
import 'package:mobile_app/widgets/service_category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            floating: true,
            flexibleSpace: customAppBar(context),
            leading: const SizedBox(),
            // pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              greetingName(context),
              const SizedBox(height: 8),
              menuSection(context),
              const SizedBox(height: 10),
              labelSection(context),
            ]),
          ),
        ],
      ),
    );
  }

  Column labelSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(
            'Daftar Kategori Layanan Tersedia',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            'Klik pada daftar kategori layanan untuk mendapatkan informasi layanan dari kategori yang dipilih',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Column(
            children: [
              Card(
                color: Theme.of(context).colorScheme.onError,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ServiceCategoryPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Lihat Semua',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          padding: EdgeInsets.zero,
          controller: scrollController,
          itemBuilder: (context, index) {
            return ServiceCategoryCard(
              title: 'Hair Cut',
              imageUrl:
                  'https://res.cloudinary.com/dk0z4ums3/image/upload/v1675244075/attached_image/pilihan-perawatan-di-salon-rambut-yang-bisa-kamu-coba.jpg',
              onTap: () {
                Get.to(
                  () => const DetailServiceCategoryPage(
                    id: 1,
                    title: 'Hair Cut',
                    imageUrl:
                        'https://res.cloudinary.com/dk0z4ums3/image/upload/v1675244075/attached_image/pilihan-perawatan-di-salon-rambut-yang-bisa-kamu-coba.jpg',
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Column menuSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Menu',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              menuButton(
                onTap: () {
                  Get.to<void>(() => const ServiceCategoryPage());
                },
                label: 'Kategori Layanan',
                icon: FluentIcons.stack_16_regular,
              ),
              menuButton(
                onTap: () {
                  Get.to(() => const ReservationPage());
                },
                label: 'Reservasi',
                icon: Icons.aod_sharp,
              ),
              menuButton(
                onTap: () {
                  Get.to(() => const ScheduleCheckPage());
                },
                label: 'Cek Jadwal',
                icon: Icons.calendar_month,
              ),
            ],
          ),
        )
      ],
    );
  }

  Container greetingName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      color: Theme.of(context).colorScheme.primary,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Hai Member, ',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          children: <TextSpan>[
            TextSpan(
              text: 'Happy Nessa M',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      leading: const SizedBox(),
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Image.asset(
                    Constants.logoSmallPath,
                    width: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Text('RCSM Mobile'),
          ],
        ),
      ),
      // title: Container(
      //   margin: const EdgeInsets.symmetric(
      //     horizontal: 10,
      //     vertical: 5,
      //   ),
      //   height: 35,
      //   child: TextField(
      //     style: Theme.of(context).textTheme.bodySmall,
      //     decoration: InputDecoration(
      //       filled: true,
      //       fillColor: Theme.of(context).colorScheme.onPrimary,
      //       hintText: 'Cari layanan...',
      //       hintStyle: Theme.of(context).textTheme.bodySmall,
      //       contentPadding: EdgeInsets.zero,
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       prefixIcon: const Icon(
      //         FluentIcons.search_12_regular,
      //         size: 12,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget menuButton({
    required void Function() onTap,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
