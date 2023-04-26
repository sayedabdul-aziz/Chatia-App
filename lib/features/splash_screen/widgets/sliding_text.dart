import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    Key? key,
    required Animation<Offset> sliding,
  })  : _sliding = sliding,
        super(key: key);

  final Animation<Offset> _sliding;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sliding,
      builder: (BuildContext context, _) => SlideTransition(
        position: _sliding,
        child: Text('Developed by\nSayed AbdulAiz❤️',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center),
      ),
    );
  }
}
