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

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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
            child: Column(
              children: List.generate(
                listSchedule.length,
                (index) => scheduleRadio(
                    context: context,
                    model: listSchedule[index],
                    selectedId: selectedSchedule.value),
              ),
            ),
          );
        },
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
