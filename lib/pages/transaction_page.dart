import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/pages/detail_service_category_page.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/schedule_page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
    this.isScheduled = false,
  }) : super(key: key);

  final bool isScheduled;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 10),
                  serviceCartDetail(context),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(
                        () => const DetailServiceCategory(
                            title: 'Perawatan Rambut', id: 5),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
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
                  if (widget.isScheduled)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            '23 Desember 2023',
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
                              '09:00 - 10:00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const SchedulePage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
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
            if (!widget.isScheduled) {
              Get.snackbar(
                'Gagal!',
                'Jadwal Belum dipilih',
                backgroundColor: Theme.of(context).colorScheme.error,
              );
            } else {
              Get.snackbar(
                'Berhasil!',
                'Reservasi berhasil di proses',
                backgroundColor: Theme.of(context).colorScheme.background,
              );
              Get.to(() => const HomePage());
            }
          },
          child: const Text('Booking'),
        ),
      ),
    );
  }

  Row serviceCartDetail(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
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
                'Perawatan Rambut',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              Text(
                'Hair Cut',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                20000.convertToIdr(),
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
            'Agus Firmansyah',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            'ahahaagus@gmail.com',
            style: Theme.of(context).textTheme.titleSmall!,
          ),
        ],
      ),
    );
  }
}
