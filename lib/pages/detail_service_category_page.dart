import 'package:flutter/material.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/widgets/service_card.dart';

class DetailServiceCategory extends StatefulWidget {
  const DetailServiceCategory({
    required this.title,
    required this.id,
    this.imageUrl,
    Key? key,
  }) : super(key: key);
  final int id;
  final String title;
  final String? imageUrl;

  @override
  State<DetailServiceCategory> createState() => _DetailServiceCategoryState();
}

class _DetailServiceCategoryState extends State<DetailServiceCategory> {
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
                  onTap: () {},
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
