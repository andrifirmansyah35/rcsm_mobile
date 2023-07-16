import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/enum.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/cubit/list_reservation_cubit.dart';
import 'package:mobile_app/models/response/list_reservation_model.dart';
import 'package:mobile_app/widgets/error_indicator.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final listReservationCubit = sl<ListReservationCubit>();

  void refresh() {
    listReservationCubit.fetchData();
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservasi'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: BlocBuilder<ListReservationCubit, ListReservationState>(
          bloc: listReservationCubit,
          builder: (context, state) {
            return Stack(
              children: [
                if (state is ListReservationSuccess)
                  ListView(
                    children: List.generate(
                      state.response.reservasiUserComplete.length,
                      (index) => reservationCard(
                        context,
                        state.response.reservasiUserComplete[index],
                      ),
                    ),
                  ),
                if (state is ListReservationLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is ListReservationFailed)
                  Center(
                    child: ErrorIndicator(
                      message: state.message,
                      onRefresh: refresh,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Card reservationCard(
    BuildContext context,
    ReservationModel model,
  ) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: InkWell(
        // onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    FluentIcons.cut_20_regular,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Reservasi Layanan',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          model.tanggal.formatToLocalFormat(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: model.status == ReservationStatusType.antri ||
                              model.status == ReservationStatusType.diproses
                          ? Theme.of(context).colorScheme.error
                          : model.status == ReservationStatusType.selesai
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      model.status.name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: model.status ==
                                        ReservationStatusType.antri ||
                                    model.status ==
                                        ReservationStatusType.diproses
                                ? Theme.of(context).colorScheme.onError
                                : model.status == ReservationStatusType.selesai
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: model.gambar != null
                        ? Image.network(
                            '${Constants.storageUrl}/${model.gambar!}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            Constants.dummyImagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.kategoriLayanan,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.layananNama,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    model.harga.convertToIdr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
