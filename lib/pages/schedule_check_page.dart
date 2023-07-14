import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/cubit/add_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/schedule_check_cubit.dart';
import 'package:mobile_app/models/request/schedule_check_body.dart';
import 'package:mobile_app/models/response/schedule_check_model.dart';
import 'package:mobile_app/pages/schedule_cart_page.dart';

class ScheduleCheckPage extends StatefulWidget {
  const ScheduleCheckPage({Key? key}) : super(key: key);

  @override
  State<ScheduleCheckPage> createState() => _ScheduleCheckPageState();
}

class _ScheduleCheckPageState extends State<ScheduleCheckPage> {
  final scheduleCheckCubit = sl<ScheduleCheckCubit>();
  final addScheduleCartCubit = sl<AddScheduleCartCubit>();

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

  void onAddScheduleCart(String idOperasi) {
    addScheduleCartCubit.fetchData(idOperasi);
  }

  void onCheckSchedule() {
    scheduleCheckCubit.fetchData(
      ScheduleCheckBody(
        tahun: selectedDate.value!.year.toString(),
        bulan: selectedDate.value!.month.toString(),
        hari: selectedDate.value!.day.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddScheduleCartCubit, AddScheduleCartState>(
      bloc: addScheduleCartCubit,
      listener: (context, state) {
        if (state is AddScheduleCartLoading) {
          Get.dialog(const Center(
            child: CircularProgressIndicator(),
          ));
        }
        if (state is AddScheduleCartFailed) {
          Get.back();
          Get.snackbar(
            'Tambah Keranjang Jadwal Gagal',
            state.message,
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
        if (state is AddScheduleCartSuccess) {
          onCheckSchedule();
          Get.back();
          Get.snackbar(
            'Berhasil Menambah Operasional',
            state.response.message,
            backgroundColor: Theme.of(context).colorScheme.primary,
            colorText: Theme.of(context).colorScheme.onPrimary,
          );
        }
      },
      child: Scaffold(
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
                            onCheckSchedule();
                          },
                    child: const Text('Cek Jadwal'),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                      valueListenable: isChecking,
                      builder: (context, checkingValue, _) {
                        if (!checkingValue) {
                          return const SizedBox();
                        }

                        return BlocBuilder<ScheduleCheckCubit,
                            ScheduleCheckState>(
                          bloc: scheduleCheckCubit,
                          builder: (context, state) {
                            if (state is ScheduleCheckSuccess &&
                                selectedDate.value != null) {
                              final data = state.response;

                              return listTimeContainer(
                                context,
                                dateValue,
                                data,
                              );
                            } else {
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: state is ScheduleCheckFailed
                                      ? Text(state.message)
                                      : state is ScheduleCheckLoading
                                          ? const CircularProgressIndicator()
                                          : const SizedBox(),
                                ),
                              );
                            }
                          },
                        );
                      })
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
      ),
    );
  }

  Column listTimeContainer(
    BuildContext context,
    DateTime? dateValue,
    List<OperasionalModel> data,
  ) {
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              GridView(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  data.length,
                  (index) {
                    return scheduleTimeCard(
                      data[index],
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

  Card scheduleTimeCard(
    OperasionalModel model,
    BuildContext context,
  ) {
    return Card(
      color: !model.status
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.onError,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          if (!model.status) {
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
            '${model.waktuMulai} - ${model.waktuSelesai}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }

  Dialog addScheduleDialog(OperasionalModel model) {
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
                    text: '${model.waktuMulai} - ${model.waktuSelesai}',
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
                      onAddScheduleCart(model.id.toString());
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
