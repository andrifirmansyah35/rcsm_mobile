import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/extensions.dart';
import 'package:mobile_app/models/response/list_service_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.data,
    this.onConfirm,
    this.margin,
    super.key,
  });

  final void Function()? onConfirm;
  final ServiceModel data;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: Color(0xFF4A4242), width: 0.2),
      ),
      child: InkWell(
        onTap: () {
          Get.dialog(
            Dialog(
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
                      'Tambah Keranjang Layanan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Apakah anda ingin menambahkan layanan ',
                        style: Theme.of(context).textTheme.bodySmall,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Creambat Organik',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' pada ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: 'Keranjang Layanan?',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                            onTap: onConfirm,
                            child: Text(
                              'Ya',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.nama,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.deskripsi ?? '-',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(data.harga.convertToIdr()),
            ],
          ),
        ),
      ),
    );
  }
}
