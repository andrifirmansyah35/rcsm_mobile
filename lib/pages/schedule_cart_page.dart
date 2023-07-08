import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/pages/transaction_page.dart';

class Schedule {
  final int id;
  final String date;
  final String time;

  const Schedule(this.id, this.date, this.time);
}

const listSchedule = [
  Schedule(
    1,
    '23 Desember 2023',
    '09:00 - 10:00',
  ),
  Schedule(
    2,
    '23 Desember 2023',
    '10:00 - 11:00',
  ),
  Schedule(
    3,
    '24 Desember 2023',
    '09:00 - 10:00',
  ),
];

class ScheduleCartPage extends StatefulWidget {
  const ScheduleCartPage({Key? key}) : super(key: key);

  @override
  State<ScheduleCartPage> createState() => _ScheduleCartPageState();
}

class _ScheduleCartPageState extends State<ScheduleCartPage> {
  final selectedSchedule = ValueNotifier<int>(listSchedule.first.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Jadwal Operasi',
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text('Tambah Operasional'),
          onPressed: () {
            Get.to(() => const TransactionPage(
                  isScheduled: true,
                ));
          },
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: selectedSchedule,
        builder: (context, value, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: List.generate(
                    listSchedule.length,
                    (index) => scheduleRadio(
                        context: context,
                        model: listSchedule[index],
                        selectedId: selectedSchedule.value),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(thickness: 8),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tidak Dapat Diproses',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              textStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            child: const Text(
                              'Hapus',
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: List.generate(
                          3,
                          (index) => expiredScheduleCard(context),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container expiredScheduleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        children: [
          const Icon(FluentIcons.clock_16_regular),
          const SizedBox(width: 10),
          const Text('23 Desember 2023'),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '09:00 - 10:00',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  RadioListTile<int> scheduleRadio({
    required BuildContext context,
    required Schedule model,
    required int selectedId,
  }) {
    return RadioListTile<int>(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              model.date,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(FluentIcons.clock_12_regular),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              model.time,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          )
        ],
      ),
      value: model.id,
      groupValue: selectedId,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      onChanged: (int? newValue) {
        selectedSchedule.value = newValue!;
      },
    );
  }
}
