import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/pages/schedule_cart_page.dart';

class TimeService {
  final int id;
  final String name;
  final bool isAvailable;

  const TimeService({
    required this.id,
    required this.name,
    required this.isAvailable,
  });
}

const listTime = [
  TimeService(id: 1, name: '09:00 - 10:00', isAvailable: true),
  TimeService(id: 12, name: '10:00 - 11:00', isAvailable: true),
  TimeService(id: 2, name: '11:00 - 12:00', isAvailable: true),
  TimeService(id: 3, name: '12:00 - 13:00', isAvailable: true),
  TimeService(id: 4, name: '13:00 - 14:00', isAvailable: true),
  TimeService(id: 5, name: '14:00 - 15:00', isAvailable: false),
  TimeService(id: 6, name: '15:00 - 16:00', isAvailable: true),
  TimeService(id: 7, name: '16:00 - 17:00', isAvailable: true),
  TimeService(id: 8, name: '17:00 - 18:00', isAvailable: false),
  TimeService(id: 9, name: '18:00 - 19:00', isAvailable: true),
  TimeService(id: 10, name: '19:00 - 20:00', isAvailable: false),
];

class ScheduleCheckPage extends StatefulWidget {
  const ScheduleCheckPage({Key? key}) : super(key: key);

  @override
  State<ScheduleCheckPage> createState() => _ScheduleCheckPageState();
}

class _ScheduleCheckPageState extends State<ScheduleCheckPage> {
  final selectedDate = ValueNotifier<DateTime?>(null);
  final isChecking = ValueNotifier<bool>(false);
  final scrollController = ScrollController();

  Future<void> onDatePick() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    selectedDate.value = date;
    isChecking.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Jadwal Operasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        controller: scrollController,
        child: ValueListenableBuilder<DateTime?>(
          valueListenable: selectedDate,
          builder: (context, dateValue, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Theme.of(context).colorScheme.background,
                  child: InkWell(
                    onTap: () {
                      onDatePick();
                    },
                    child: datePickButton(dateValue),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: selectedDate.value == null
                      ? null
                      : () {
                          isChecking.value = true;
                        },
                  child: const Text('Cek Jadwal Operasi Layanan'),
                ),
                const SizedBox(height: 10),
                listScheduleSection(dateValue)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.onBackground,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const ScheduleCartPage());
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.cart_20_regular),
              SizedBox(width: 10),
              Text('Lihat Keranjang Operasi'),
            ],
          ),
        ),
      ),
    );
  }

  Padding datePickButton(DateTime? dateValue) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month,
          ),
          const SizedBox(width: 10),
          if (dateValue != null)
            Text(dateValue.formatToString())
          else
            const Text(
              'Pilih Jadwal Operasi Layanan',
            ),
        ],
      ),
    );
  }

  ValueListenableBuilder<bool> listScheduleSection(DateTime? dateValue) {
    return ValueListenableBuilder(
      valueListenable: isChecking,
      builder: (context, isCheckingValue, _) {
        if (isCheckingValue) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pilih Jam Layanan Operasi',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Jadwal Operasi ',
                        style: Theme.of(context).textTheme.bodySmall!,
                        children: <TextSpan>[
                          TextSpan(
                            text: dateValue!.formatToString(),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    GridView(
                      controller: scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 35,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      children: List.generate(
                        listTime.length,
                        (index) {
                          return scheduleTimeCard(
                            listTime[index],
                            context,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onError,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Dipesan')
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Tersedia')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Card scheduleTimeCard(TimeService model, BuildContext context) {
    return Card(
      color: model.isAvailable
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.onError,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          if (model.isAvailable) {
            Get.dialog(addScheduleDialog(model));
          } else {
            Get.closeAllSnackbars();
            Get.snackbar(
              'Gagal',
              'Jadwal Operasi yang dipilih sudah terisi, silahkan pilih jadwal lain yang tersedia',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          }
        },
        child: Center(
          child: Text(
            model.name,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }

  Dialog addScheduleDialog(TimeService model) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tambah Keranjang Operasi',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Apakah anda ingin menambahkan jadwal Operasi ',
                style: Theme.of(context).textTheme.bodySmall,
                children: <TextSpan>[
                  TextSpan(
                    text: selectedDate.value!.formatToString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' pada waktu ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: model.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: '?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Text('Tidak'),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.snackbar(
                        'Berhasil',
                        'Jadwal Operasi berhasil ditambah ke Keranjang Operasi',
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        colorText: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Text(
                      'Ya',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
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
