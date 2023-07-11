import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/service_category_cubit.dart';
import 'package:mobile_app/models/response/service_category_model.dart';
import 'package:mobile_app/pages/reservation_page.dart';
import 'package:mobile_app/pages/schedule_check_page.dart';
import 'package:mobile_app/pages/service_category_page.dart';
import 'package:mobile_app/widgets/custom_drawer.dart';
import 'package:mobile_app/widgets/service_category_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  final serviceCategoryCubit = sl<ServiceCategoryCubit>();
  final prefs = sl<SharedPreferences>();

  void refresh() {
    serviceCategoryCubit.fetchData();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final memberName = prefs.getString(Constants.keyMemberName);

    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxScrolled) => [
              SliverAppBar(
                expandedHeight: 50.0,
                floating: true,
                flexibleSpace: customAppBar(context),
                leading: const SizedBox(),
                // pinned: true,
              ),
            ],
            body: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    greetingName(context, memberName ?? ''),
                    const SizedBox(height: 8),
                    menuSection(context),
                    const SizedBox(height: 10),
                    BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
                      bloc: serviceCategoryCubit,
                      builder: (context, state) {
                        if (state is ServiceCategorySuccess) {
                          return servieCategorySection(context, state.response);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: state is ServiceCategoryFailed
                                ? Center(child: Text(state.message))
                                : state is ServiceCategoryLoading
                                    ? const CircularProgressIndicator()
                                    : const SizedBox(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column servieCategorySection(
    BuildContext context,
    List<ServiceCategoryModel> data,
  ) {
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
          itemCount: data.length,
          padding: EdgeInsets.zero,
          controller: scrollController,
          itemBuilder: (context, index) {
            return ServiceCategoryCard(data: data[index]);
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

  Container greetingName(BuildContext context, String memberName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
      color: Theme.of(context).colorScheme.primary,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Hai Member',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          children: <TextSpan>[
            TextSpan(
              text: ', $memberName',
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
