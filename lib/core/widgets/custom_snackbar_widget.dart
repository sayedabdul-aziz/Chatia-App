import 'package:flutter/material.dart';

class CustomSnackBarWidget extends StatelessWidget {
  const CustomSnackBarWidget(
      {super.key, required this.content, required this.color});
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(label: 'ok', onPressed: () {}),
    );
  }
}
