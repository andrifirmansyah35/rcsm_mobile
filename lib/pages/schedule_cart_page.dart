import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/extensions.dart';
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

  final selectedSchedule = ValueNotifier<int>(0);

  void refresh() {
    listScheduleCartCubit.fetchData();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListScheduleCartCubit, ListScheduleCartState>(
      bloc: listScheduleCartCubit,
      listener: (context, state) {
        if (state is ListScheduleCartSuccess) {
          if (state.response.keranjangOperasiBuka.isNotEmpty) {
            selectedSchedule.value =
                state.response.keranjangOperasiBuka.first.id;
          }
        }
      },
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
                            final schedule =
                                state.response.keranjangOperasiBuka.firstWhere(
                              (element) => element.id == selectedSchedule.value,
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
                  ErrorIndicator(
                    message: state.message,
                    onRefresh: refresh,
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
                                    state.response.keranjangOperasiBuka.length,
                                    (index) => scheduleRadio(
                                      context: context,
                                      model: state
                                          .response.keranjangOperasiBuka[index],
                                      selectedId: selectedSchedule.value,
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  height: Get.height / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Keranjang Jadwal kamu masih kosong',
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        child: const Text('Tambah Jadwal Baru'),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tidak Dapat Diproses',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            child: const Text(
                                              'Hapus',
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: List.generate(
                                          state.response
                                              .keranjangOperasiTerblokir.length,
                                          (index) => expiredScheduleCard(
                                              context,
                                              state.response
                                                      .keranjangOperasiTerblokir[
                                                  index]),
                                        ),
                                      )
                                    ],
                                  ),
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
          Text(model.jadwalOperasi),
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
