import 'package:flutter/material.dart';

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: 1.1,
            child: Image.asset('assets/imgs/p1.png', fit: BoxFit.cover),
          ),

          // Dark linear gradient to improve contrast for the card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.25), Colors.black.withOpacity(0.6)],
              ),
            ),
          ),

          // Subtle radial vignette for focus
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 0.8,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.45)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
