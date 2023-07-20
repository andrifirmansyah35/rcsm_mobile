import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/cubit/delete_closed_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/delete_schedule_cart_cubit.dart';
import 'package:mobile_app/cubit/list_schedule_cart_cubit.dart';
import 'package:mobile_app/models/response/schedule_cart_model.dart';
import 'package:mobile_app/models/response/service_cart_model.dart';
import 'package:mobile_app/pages/schedule_check_page.dart';
import 'package:mobile_app/pages/transaction_page.dart';
import 'package:mobile_app/widgets/error_indicator.dart';

class ScheduleCartPage extends StatefulWidget {
  const ScheduleCartPage({
    this.serviceCartModel,
    Key? key,
  }) : super(key: key);

  final ServiceCartModel? serviceCartModel;

  @override
  State<ScheduleCartPage> createState() => _ScheduleCartPageState();
}

class _ScheduleCartPageState extends State<ScheduleCartPage> {
  final listScheduleCartCubit = sl<ListScheduleCartCubit>();
  final deleteClosedScheduleCartCubit = sl<DeleteClosedScheduleCartCubit>();
  final deleteScheduleCartCubit = sl<DeleteScheduleCartCubit>();

  final selectedSchedule = ValueNotifier<int>(0);

  void refresh() {
    listScheduleCartCubit.fetchData();
  }

  void onDeleteSchedule(ScheduleCartModel model) {
    Get.dialog(
      dialogDeleteService(model, () {
        deleteScheduleCartCubit.fetchData(model.id);
      }),
    );
  }

  void onDeleteAll() {
    Get.dialog(
      dialogDeleteAll(() {
        deleteClosedScheduleCartCubit.fetchData();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ListScheduleCartCubit, ListScheduleCartState>(
          bloc: listScheduleCartCubit,
          listener: (context, state) {
            if (state is ListScheduleCartSuccess) {
              if (state.response.keranjangOperasiBuka.isNotEmpty) {
                selectedSchedule.value =
                    state.response.keranjangOperasiBuka.first.id;
              }
            }
          },
        ),
        BlocListener<DeleteClosedScheduleCartCubit,
            DeleteClosedScheduleCartState>(
          bloc: deleteClosedScheduleCartCubit,
          listener: (context, state) {
            if (state is DeleteClosedScheduleCartSuccess) {
              Get.snackbar(
                'Berhasil',
                state.response.message,
                backgroundColor: Theme.of(context).colorScheme.background,
                colorText: Theme.of(context).colorScheme.primary,
              );
              refresh();
            }

            if (state is DeleteClosedScheduleCartFailed) {
              Get.snackbar(
                'Gagal',
                state.message,
                backgroundColor: Theme.of(context).colorScheme.error,
                colorText: Theme.of(context).colorScheme.primary,
              );
            }
          },
        ),
        BlocListener<DeleteScheduleCartCubit, DeleteScheduleCartState>(
          bloc: deleteScheduleCartCubit,
          listener: (context, state) {
            if (state is DeleteScheduleCartSuccess) {
              Get.snackbar(
                'Berhasil',
                state.response.message,
                backgroundColor: Theme.of(context).colorScheme.background,
                colorText: Theme.of(context).colorScheme.primary,
              );
              refresh();
            }

            if (state is DeleteScheduleCartFailed) {
              Get.snackbar(
                'Gagal',
                state.message,
                backgroundColor: Theme.of(context).colorScheme.error,
                colorText: Theme.of(context).colorScheme.primary,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ListScheduleCartCubit, ListScheduleCartState>(
        bloc: listScheduleCartCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Keranjang Jadwal Operasi',
              ),
            ),
            bottomNavigationBar: state is ListScheduleCartSuccess
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: state.response.keranjangOperasiBuka.isNotEmpty
                        ? ElevatedButton(
                            child: const Text('Tambah Operasional'),
                            onPressed: () {
                              final schedule = state
                                  .response.keranjangOperasiBuka
                                  .firstWhere(
                                (element) =>
                                    element.id == selectedSchedule.value,
                              );
                              Get.to(
                                () => TransactionPage(
                                  scheduleCartModel: schedule,
                                  selectedService: widget.serviceCartModel,
                                ),
                                preventDuplicates: false,
                              );
                            },
                          )
                        : null,
                  )
                : null,
            body: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: Stack(
                children: [
                  if (state is ListScheduleCartLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is ListScheduleCartFailed)
                    Center(
                      child: ErrorIndicator(
                        message: state.message,
                        onRefresh: refresh,
                      ),
                    ),
                  if (state is ListScheduleCartSuccess)
                    ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: selectedSchedule,
                          builder: (context, value, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (state
                                    .response.keranjangOperasiBuka.isNotEmpty)
                                  Column(
                                    children: List.generate(
                                      state
                                          .response.keranjangOperasiBuka.length,
                                      (index) => scheduleRadio(
                                          context: context,
                                          model: state.response
                                              .keranjangOperasiBuka[index],
                                          selectedId: selectedSchedule.value,
                                          onDelete: () => onDeleteSchedule(
                                                state.response
                                                        .keranjangOperasiBuka[
                                                    index],
                                              )),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    height: Get.height / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Keranjang Jadwal kamu masih kosong',
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          child:
                                              const Text('Tambah Jadwal Baru'),
                                          onPressed: () {
                                            Get.to(
                                              () => ScheduleCheckPage(
                                                serviceCartModel:
                                                    widget.serviceCartModel,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 5),
                                const Divider(thickness: 8),
                                const SizedBox(height: 5),
                                if (state.response.keranjangOperasiTerblokir
                                    .isNotEmpty)
                                  expiredScheduleSection(
                                    context,
                                    state,
                                    onDeleteAll,
                                  )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding expiredScheduleSection(
    BuildContext context,
    ListScheduleCartSuccess state,
    void Function() onDelete,
  ) {
    return Padding(
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
                onPressed: () {
                  onDelete();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: Theme.of(context).textTheme.labelMedium,
                ),
                child: const Text(
                  'Hapus',
                ),
              )
            ],
          ),
          Column(
            children: List.generate(
              state.response.keranjangOperasiTerblokir.length,
              (index) => expiredScheduleCard(
                context,
                state.response.keranjangOperasiTerblokir[index],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container expiredScheduleCard(
    BuildContext context,
    ScheduleCartModel model,
  ) {
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
          Text(model.jadwalOperasi.formatToLocalFormat()),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              model.operasi,
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
    required ScheduleCartModel model,
    required int selectedId,
    void Function()? onDelete,
  }) {
    return RadioListTile<int>(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              model.jadwalOperasi.formatToLocalFormat(),
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
              model.operasi,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: onDelete,
            child: const Icon(FluentIcons.delete_12_regular),
          ),
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

  Dialog dialogDeleteService(
      ScheduleCartModel model, void Function() onDelete) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              'Hapus Jadwal Operasi',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Apakah anda ingin menghapus jadwal operasi hari ',
                style: Theme.of(context).textTheme.bodySmall,
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${model.jadwalOperasi.formatToLocalFormat()}, ${model.operasi}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' dari keranjang Operasi?',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Get.back();
                    onDelete();
                  },
                  child: Text(
                    'Ya, Hapus',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Dialog dialogDeleteAll(void Function() onDelete) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              'Hapus Jadwal Operasi',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Apakah anda ingin menghapus semua jadwal yang ditutup pada keranjang jadwal operasi?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'Batalkan',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Get.back();
                    onDelete();
                  },
                  child: Text(
                    'Ya, Hapus',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
