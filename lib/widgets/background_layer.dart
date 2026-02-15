import 'package:flutter/material.dart';

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          _buildCircle(top: 100, left: 50, color: Colors.blueAccent),
          _buildCircle(bottom: 150, right: 30, color: Colors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildCircle({double? top, double? left, double? right, double? bottom, required Color color}) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.2),
        ),
      ),
    );
  }
}