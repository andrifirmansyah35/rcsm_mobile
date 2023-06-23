import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/pages/service_category_page.dart';
import 'package:mobile_app/widgets/service_card.dart';

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
      endDrawer: const Drawer(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            floating: true,
            flexibleSpace: customAppBar(context),
            // pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              greetingName(context),
              const SizedBox(height: 15),
              menuSection(context),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Mungkin ini layanan yang kamu cari',
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        title: 'Creambath Organik',
                        description: 'Perawatan Rambut',
                        price: 20000,
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
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
                onTap: () {},
                label: 'Pesanan',
                icon: FluentIcons.cart_16_regular,
              ),
              menuButton(
                onTap: () {},
                label: 'Jadwal',
                icon: FluentIcons.calendar_agenda_20_regular,
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
      titleSpacing: 0,
      elevation: 0,
      title: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        height: 35,
        child: TextField(
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            hintText: 'Cari layanan...',
            hintStyle: Theme.of(context).textTheme.bodySmall,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(
              FluentIcons.search_12_regular,
              size: 12,
            ),
          ),
        ),
      ),
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
