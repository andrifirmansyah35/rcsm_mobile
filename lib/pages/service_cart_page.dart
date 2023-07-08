import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/pages/transaction_page.dart';

class CartModel {
  final int id;
  final String title;
  final String desc;
  final int price;

  CartModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
  });
}

final listCart = [
  CartModel(
    id: 1,
    title: 'Perawatan Rambut',
    desc: 'Hair Cut ',
    price: 20000,
  ),
  CartModel(
    id: 2,
    title: 'Perawatan Rambut',
    desc: 'Semir',
    price: 25000,
  ),
  CartModel(
    id: 3,
    title: 'Perawatan Rambut',
    desc: 'Semir',
    price: 25000,
  ),
  CartModel(
    id: 4,
    title: 'Perawatan Rambut',
    desc: 'Semir',
    price: 25000,
  ),
];

class ServiceCardPage extends StatefulWidget {
  const ServiceCardPage({Key? key}) : super(key: key);

  @override
  State<ServiceCardPage> createState() => _ServiceCardPageState();
}

class _ServiceCardPageState extends State<ServiceCardPage> {
  final selectedServiceId = ValueNotifier<int>(listCart.first.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedServiceId,
          builder: (context, value, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: List.generate(
                    listCart.length,
                    (index) => serviceCartRadio(
                      context: context,
                      model: listCart[index],
                      selectedValue: value,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Column(
                  children: [
                    closedServiceHeading(
                      context: context,
                      onDelete: () {},
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: closedServiceCard(context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Card(
        color: Theme.of(context).colorScheme.onBackground,
        elevation: 50,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const TransactionPage());
            },
            child: const Text('Pilih Layanan'),
          ),
        ),
      ),
    );
  }

  Row closedServiceHeading({
    required BuildContext context,
    void Function()? onDelete,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Layanan Sedang Ditutup',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        OutlinedButton(
          onPressed: onDelete,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            textStyle: Theme.of(context).textTheme.labelMedium,
          ),
          child: const Text(
            'Hapus',
          ),
        )
      ],
    );
  }

  ListTile closedServiceCard(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perawatan Rambut',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                'Hair Cut',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ],
          ),
          Text(
            20000.convertToIdr(),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
      tileColor: Theme.of(context).colorScheme.errorContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  RadioListTile<int> serviceCartRadio({
    required BuildContext context,
    required CartModel model,
    required int selectedValue,
    void Function()? onDelete,
  }) {
    final isSelected = selectedValue == model.id;
    return RadioListTile<int>(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                ),
                Text(
                  model.desc,
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            model.price.convertToIdr(),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: onDelete,
            child: const Icon(FluentIcons.delete_12_regular),
          )
        ],
      ),
      value: model.id,
      groupValue: selectedValue,
      tileColor: isSelected
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).colorScheme.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      onChanged: (int? newValue) {
        selectedServiceId.value = newValue!;
      },
    );
  }
}
