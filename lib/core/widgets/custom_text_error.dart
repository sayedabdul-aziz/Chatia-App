import 'package:flutter/material.dart';

class CustomTextError extends StatelessWidget {
  const CustomTextError({
    super.key,
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context) {
    return Text(
      error,
    );
  }
}
