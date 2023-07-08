import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FluentIcons.service_bell_16_regular,
                      ),
                      Column(
                        children: [
                          Text('Reservasi Layanan'),
                          Text('24 Desember 2023'),
                        ],
                      ),
                      
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
