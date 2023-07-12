import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/service_category_model.dart';
import 'package:mobile_app/pages/detail_service_category_page.dart';

class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ServiceCategoryModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(
            () => DetailServiceCategoryPage(
              data: data,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  image: NetworkImage('${Constants.storageUrl}/${data.gambar}'),
                  placeholder: const AssetImage(
                    Constants.dummyImagePath,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.nama,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${data.jumlahLayanan} Layanan',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(FluentIcons.chevron_right_16_filled)
            ],
          ),
        ),
      ),
    );
  }
}
