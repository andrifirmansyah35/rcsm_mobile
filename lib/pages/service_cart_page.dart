import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/cubit/list_service_cart_cubit.dart';
import 'package:mobile_app/models/response/schedule_cart_model.dart';
import 'package:mobile_app/models/response/service_cart_model.dart';
import 'package:mobile_app/pages/service_category_page.dart';
import 'package:mobile_app/pages/transaction_page.dart';
import 'package:mobile_app/widgets/error_indicator.dart';

class ServiceCartPage extends StatefulWidget {
  const ServiceCartPage({
    Key? key,
    this.scheduleCartModel,
  }) : super(key: key);

  final ScheduleCartModel? scheduleCartModel;

  @override
  State<ServiceCartPage> createState() => _ServiceCartPageState();
}

class _ServiceCartPageState extends State<ServiceCartPage> {
  final selectedServiceId = ValueNotifier<int>(0);
  final listServiceCartCubit = sl<ListServiceCartCubit>();

  void refresh() {
    listServiceCartCubit.fetchData();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListServiceCartCubit, ListServiceCartState>(
      bloc: listServiceCartCubit,
      listener: (context, state) {
        if (state is ListServiceCartSuccess) {
          if (state.response.dataKeranjangLayananOpen.isNotEmpty) {
            selectedServiceId.value = state
                .response.dataKeranjangLayananOpen.first.idKeranjangLayanan;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Keranjang Layanan'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (state is ListServiceCartSuccess)
                ValueListenableBuilder<int>(
                  valueListenable: selectedServiceId,
                  builder: (context, value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state.response.dataKeranjangLayananOpen.isNotEmpty)
                          Column(
                            children: List.generate(
                              state.response.dataKeranjangLayananOpen.length,
                              (index) => serviceCartRadio(
                                context: context,
                                model: state
                                    .response.dataKeranjangLayananOpen[index],
                                selectedValue: value,
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
                                  'Keranjang Layanan kamu masih kosong',
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  child: const Text('Tambah Layanan'),
                                  onPressed: () {
                                    Get.to(
                                      () => ServiceCategoryPage(
                                        scheduleCartModel:
                                            widget.scheduleCartModel,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        const Divider(),
                        if (state.response.dataKeranjangClose.isNotEmpty)
                          Column(
                            children: [
                              closedServiceHeading(
                                context: context,
                                onDelete: () {},
                              ),
                              const SizedBox(height: 5),
                              Column(
                                children: List.generate(
                                  state.response.dataKeranjangClose.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: closedServiceCard(
                                        context,
                                        state.response
                                            .dataKeranjangClose[index]),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    );
                  },
                )
              else
                SizedBox(
                  height: Get.height,
                  child: Center(
                    child: state is ListServiceCartFailed
                        ? ErrorIndicator(
                            message: state.message,
                          )
                        : state is ListServiceCartLoading
                            ? const CircularProgressIndicator()
                            : const SizedBox(),
                  ),
                )
            ],
          ),
          bottomNavigationBar: state is ListServiceCartSuccess
              ? Card(
                  color: Theme.of(context).colorScheme.onBackground,
                  elevation: 50,
                  margin: EdgeInsets.zero,
                  child: state.response.dataKeranjangLayananOpen.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              final selectedService = state
                                  .response.dataKeranjangLayananOpen
                                  .firstWhere(
                                (element) =>
                                    element.idKeranjangLayanan ==
                                    selectedServiceId.value,
                              );
                              Get.to(
                                () => TransactionPage(
                                  selectedService: selectedService,
                                  scheduleCartModel: widget.scheduleCartModel,
                                ),
                                preventDuplicates: false,
                              );
                            },
                            child: const Text('Pilih Layanan'),
                          ),
                        )
                      : null,
                )
              : null,
        );
      },
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

  ListTile closedServiceCard(
    BuildContext context,
    ServiceCartModel model,
  ) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.kategoriLayanan,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                model.layanan,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ],
          ),
          Text(
            model.harga.convertToIdr(),
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
    required ServiceCartModel model,
    required int selectedValue,
    void Function()? onDelete,
  }) {
    final isSelected = selectedValue == model.idKeranjangLayanan;
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
                  model.kategoriLayanan,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                ),
                Text(
                  model.layanan,
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            model.harga.convertToIdr(),
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
      value: model.idKeranjangLayanan,
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
