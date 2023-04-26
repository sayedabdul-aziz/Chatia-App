import 'package:flutter/material.dart';
import 'widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text('Developed by\nSayed AbdulAiz 💜',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
        ),
        body: const SplashBody());
  }
}
