import 'package:flutter/material.dart';

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Transform.scale(
        scale: 1.1,
        child: Image.asset('assets/imgs/p1.png', fit: BoxFit.cover),
      ),
    );
  }
}
