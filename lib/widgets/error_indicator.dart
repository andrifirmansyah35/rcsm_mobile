import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    Key? key,
    required this.message,
    this.onRefresh,
  }) : super(key: key);

  final String message;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: onRefresh,
          child: const Text('Muat Ulang'),
        )
      ],
    );
  }
}
