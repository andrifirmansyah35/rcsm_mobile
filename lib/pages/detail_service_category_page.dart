import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/pages/service_cart_page.dart';
import 'package:mobile_app/widgets/service_card.dart';

class DetailServiceCategoryPage extends StatefulWidget {
  const DetailServiceCategoryPage({
    required this.title,
    required this.id,
    this.imageUrl,
    Key? key,
  }) : super(key: key);
  final int id;
  final String title;
  final String? imageUrl;

  @override
  State<DetailServiceCategoryPage> createState() =>
      _DetailServiceCategoryState();
}

class _DetailServiceCategoryState extends State<DetailServiceCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Layanan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.imageUrl != null
                        ? Image.network(
                            widget.imageUrl!,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          'Perawatan Rambut',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          'Kategori',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 5, height: 5),
            const SizedBox(height: 5),
            Column(
              children: List.generate(
                10,
                (index) => ServiceCard(
                  price: 20000,
                  title: 'Creambat Organik',
                  description:
                      'Perawatan Rambut Perawatan Rambut Perawatan Rambut Perawatan Rambut Perawatan Rambut Perawatan Rambut ',
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  text:
                                      'Apakah anda ingin menambahkan layanan ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Creambat Organik',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' pada ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    TextSpan(
                                      text: 'Keranjang Layanan?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
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
                                      onTap: () {
                                        // TODO: Tambah keranjang
                                        Get.back();
                                        Get.to(() => const ServiceCartPage());
                                      },
                                      child: Text(
                                        'Ya',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
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
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
