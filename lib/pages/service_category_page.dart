import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/pages/detail_service_category_page.dart';
import 'package:mobile_app/widgets/service_category_card.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  State<ServiceCategoryPage> createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState extends State<ServiceCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: List.generate(
            10,
            (index) => ServiceCategoryCard(
              title: 'Perawatan Rambut',
              imageUrl:
                  'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
              onTap: () => Get.to<void>(
                () => const DetailServiceCategory(
                  id: 1,
                  title: 'Perawatan Rambut',
                  imageUrl:
                      'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
