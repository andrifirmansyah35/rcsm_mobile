import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/cubit/add_reservation_cubit.dart';
import 'package:mobile_app/models/request/reservation_body.dart';
import 'package:mobile_app/models/response/schedule_cart_model.dart';
import 'package:mobile_app/models/response/service_cart_model.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/schedule_cart_page.dart';
import 'package:mobile_app/pages/service_cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    this.selectedService,
    this.scheduleCartModel,
    Key? key,
  }) : super(key: key);

  final ServiceCartModel? selectedService;
  final ScheduleCartModel? scheduleCartModel;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final addReservationCubit = sl<AddReservationCubit>();
  final prefs = sl<SharedPreferences>();

  void bookingReservation() {
    addReservationCubit.fetchData(ReservationBody(
      idLayanan: widget.selectedService!.idLayanan.toString(),
      idOperasi: widget.scheduleCartModel!.idOperasi.toString(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddReservationCubit, AddReservationState>(
      bloc: addReservationCubit,
      listener: (context, state) {
        if (state is AddReservationLoading) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
        }
        if (state is AddReservationFailed) {
          Get.back();
          Get.snackbar(
            'Proses Reservasi Gagal!',
            state.message,
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
        if (state is AddReservationSuccess) {
          Get.back();
          Get.snackbar(
            'Berhasil Memproses Reservasi',
            state.response.message,
            backgroundColor: Theme.of(context).colorScheme.background,
          );

          Get.offAll(() => const HomePage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Buat Transaksi'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                transactionHeader(context),
                const SizedBox(height: 5),
                const Divider(
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Layanan',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (widget.selectedService != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: serviceCartDetail(context),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            ServiceCartPage(
                              scheduleCartModel: widget.scheduleCartModel,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.inverseSurface,
                        ),
                        child: const Row(
                          children: [
                            Icon(FluentIcons.service_bell_16_regular),
                            Expanded(
                              child: Text(
                                'Pilih Layanan',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(FluentIcons.chevron_right_16_filled)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Jadwal Operasi',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      if (widget.scheduleCartModel != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: scheduleCard(context),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => ScheduleCartPage(
                              serviceCartModel: widget.selectedService,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.inverseSurface,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Expanded(
                              child: Text(
                                'Pilih Jadwal Operasi Layanan',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(FluentIcons.chevron_right_16_filled)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (widget.scheduleCartModel == null ||
                    widget.selectedService == null) {
                  Get.snackbar(
                    'Gagal!',
                    'Data Reservasi belum lengkap',
                    backgroundColor: Theme.of(context).colorScheme.error,
                  );
                } else {
                  bookingReservation();
                }
              },
              child: const Text('Booking'),
            ),
          ),
        );
      },
    );
  }

  Row scheduleCard(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.scheduleCartModel!.jadwalOperasi.formatToLocalFormat(),
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.scheduleCartModel!.operasi,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        )
      ],
    );
  }

  Row serviceCartDetail(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FadeInImage(
            image: NetworkImage(
              '${Constants.storageUrl}/${widget.selectedService!.gambarKategoriLayanan}',
            ),
            placeholder: const AssetImage(
              Constants.dummyImagePath,
            ),
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              Constants.dummyImagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        if (widget.selectedService != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.selectedService!.kategoriLayanan,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.selectedService!.layanan,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  widget.selectedService!.harga.convertToIdr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Padding transactionHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Profil Member',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 5),
          Text(
            prefs.getString(Constants.keyMemberName) ?? '',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            prefs.getString(Constants.keyMemberEmail) ?? '',
            style: Theme.of(context).textTheme.titleSmall!,
          ),
        ],
      ),
    );
  }
}
