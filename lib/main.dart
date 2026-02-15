import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'widgets/glass_card.dart';
import 'widgets/background_layer.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CombinedGyroTouchCard(),
  ),
);

class CombinedGyroTouchCard extends StatefulWidget {
  const CombinedGyroTouchCard({super.key});

  @override
  State<CombinedGyroTouchCard> createState() => _CombinedGyroTouchCardState();
}

class _CombinedGyroTouchCardState extends State<CombinedGyroTouchCard> {
  // قيم الحساس (Gyroscope)
  double gyroX = 0, gyroY = 0;
  // قيم اللمس (Touch)
  double touchX = 0, touchY = 0;

  @override
  void initState() {
    super.initState();
    // استخدام uiInterval لزيادة سرعة الاستجابة وسلاسة الحركة
    gyroscopeEventStream(samplingPeriod: SensorInterval.gameInterval).listen((
      GyroscopeEvent event,
    ) {
      if (!mounted) return;
      setState(() {
        // زيادة الحساسية (0.15 بدلاً من 0.05) مع إضافةdamping خفيف
        gyroX = (gyroX + event.x * 0.15).clamp(-0.6, 0.6);
        gyroY = (gyroY + event.y * 0.15).clamp(-0.6, 0.6);

        // لمحاكاة الرجوع للمنتصف ببطء (Damping)
        gyroX *= 0.98;
        gyroY *= 0.98;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // إضافة تأثير الحركية للخلفية (Parallax) لتجربة أكثر واقعية
          Transform(
            transform: Matrix4.identity()..translate(-gyroY * 25, -gyroX * 25),
            child: const BackgroundLayer(),
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                // حساسية اللمس أعلى مع حدود للتحكم في الدوران
                touchY = (touchY + details.delta.dx * 0.02).clamp(-0.8, 0.8);
                touchX = (touchX + details.delta.dy * -0.02).clamp(-0.8, 0.8);
              });
            },
            child: Center(
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002) // تأثير العمق
                  ..rotateX(gyroX + touchX) // دمج الحركتين
                  ..rotateY(gyroY + touchY),
                alignment: FractionalOffset.center,
                child: const GlassCard(
                  cardHolder: "FLUTTER DEVELOPER",
                  cardNumber: "4521  **** **** 1245",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
