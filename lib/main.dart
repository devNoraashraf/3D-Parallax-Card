import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'widgets/glass_card.dart';
import 'widgets/background_layer.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GyroScopePortfolio(),
    ));

class GyroScopePortfolio extends StatefulWidget {
  const GyroScopePortfolio({super.key});

  @override
  State<GyroScopePortfolio> createState() => _GyroScopePortfolioState();
}

class _GyroScopePortfolioState extends State<GyroScopePortfolio> {
  double x = 0, y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundLayer(),
          Center(
            child: StreamBuilder<GyroscopeEvent>(
              stream: gyroscopeEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // تحديث الإحداثيات بناءً على الحساس
                  y += snapshot.data!.y * 0.15;
                  x += snapshot.data!.x * 0.15;
                }

                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002) // تأثير الـ 3D
                    ..rotateX(x)
                    ..rotateY(y),
                  alignment: FractionalOffset.center,
                  child: const GlassCard(
                    cardHolder: "FLUTTER DEVELOPER",
                    cardNumber: "4521  **** **** 1245",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}