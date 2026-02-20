import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'widgets/glass_card.dart';
import 'widgets/background_layer.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CombinedGyroTouchCard(),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
    );

class CombinedGyroTouchCard extends StatefulWidget {
  const CombinedGyroTouchCard({super.key});

  @override
  State<CombinedGyroTouchCard> createState() => _CombinedGyroTouchCardState();
}

class _CombinedGyroTouchCardState extends State<CombinedGyroTouchCard> {
  double gyroX = 0, gyroY = 0;

  double touchX = 0, touchY = 0;
  bool _entered = false;

  @override
  void initState() {
    super.initState();

    gyroscopeEventStream(samplingPeriod: SensorInterval.gameInterval).listen((
      GyroscopeEvent event,
    ) {
      if (!mounted) return;
      setState(() {
        gyroX = (gyroX + event.x * 0.15).clamp(-0.6, 0.6);
        gyroY = (gyroY + event.y * 0.15).clamp(-0.6, 0.6);

        gyroX *= 0.98;
        gyroY *= 0.98;
      });
    });

    // small entrance animation for nicer screenshot composition
    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      setState(() => _entered = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Stack(
        children: [
          const BackgroundLayer(),

          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                touchY = (touchY + details.delta.dx * 0.02).clamp(-0.8, 0.8);
                touchX = (touchX + details.delta.dy * -0.02).clamp(-0.8, 0.8);
              });
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: _entered ? 1.0 : 0.92,
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 420),
                      opacity: _entered ? 1 : 0,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..rotateX(gyroX + touchX)
                          ..rotateY(gyroY + touchY),
                        alignment: FractionalOffset.center,
                        child: const GlassCard(
                          cardHolder: "NORA ASHRAF",
                          cardNumber: "FLUTTER DEVELOPER",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                  Text(
                    'NORA ASHRAF — Flutter Developer',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
