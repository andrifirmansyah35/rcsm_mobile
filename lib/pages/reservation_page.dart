import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/common/extensions.dart';

enum ReservationStatus { antre, done, canceled }

class ReservationModel {
  final int id;
  final String date;
  final String name;
  final String desc;
  final int price;
  final ReservationStatus status;
  final String? imageUrl;

  const ReservationModel({
    required this.id,
    required this.date,
    required this.name,
    required this.desc,
    required this.price,
    required this.status,
    this.imageUrl,
  });
}

const listReservation = [
  ReservationModel(
    id: 1,
    date: '23 Desember 2023',
    imageUrl:
        'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.antre,
  ),
  ReservationModel(
    id: 2,
    date: '23 Desember 2023',
    imageUrl:
        'https://res.cloudinary.com/dk0z4ums3/image/upload/v1675244075/attached_image/pilihan-perawatan-di-salon-rambut-yang-bisa-kamu-coba.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.done,
  ),
  ReservationModel(
    id: 3,
    date: '23 Desember 2023',
    imageUrl:
        'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.canceled,
  ),
  ReservationModel(
    id: 4,
    date: '23 Desember 2023',
    imageUrl:
        'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.antre,
  ),
  ReservationModel(
    id: 5,
    date: '23 Desember 2023',
    imageUrl:
        'https://res.cloudinary.com/dk0z4ums3/image/upload/v1675244075/attached_image/pilihan-perawatan-di-salon-rambut-yang-bisa-kamu-coba.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.done,
  ),
  ReservationModel(
    id: 6,
    date: '23 Desember 2023',
    imageUrl:
        'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/07/01103723/Beragam-Pilihan-Perawatan-Rambut-di-Salon-Kecantikan.jpg',
    name: 'Perawatan Rambut',
    desc: 'Hair Cut',
    price: 20000,
    status: ReservationStatus.canceled,
  ),
];

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservasi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            listReservation.length,
            (index) => reservationCard(
              context,
              listReservation[index],
            ),
          ),
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
        onTap: () {},
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
                          model.date,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: model.status == ReservationStatus.antre
                          ? Theme.of(context).colorScheme.error
                          : model.status == ReservationStatus.done
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      model.status == ReservationStatus.antre
                          ? 'Mengantri'
                          : model.status == ReservationStatus.done
                              ? 'Selesai'
                              : 'Dibatalkan',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: model.status == ReservationStatus.canceled
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
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
                    child: model.imageUrl != null
                        ? Image.network(
                            model.imageUrl!,
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
                          model.name,
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
                          model.desc,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    model.price.convertToIdr(),
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
