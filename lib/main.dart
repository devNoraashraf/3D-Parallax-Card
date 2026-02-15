import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ThreeDCardScanner()));

class ThreeDCardScanner extends StatefulWidget {
  const ThreeDCardScanner({super.key});

  @override
  State<ThreeDCardScanner> createState() => _ThreeDCardScannerState();
}

class _ThreeDCardScannerState extends State<ThreeDCardScanner> {

  double rotationX = 0;
  double rotationY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), 
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              rotationY += details.delta.dx * 0.01;
              rotationX += details.delta.dy * -0.01;
            });
          },
      
          onPanEnd: (_) => setState(() {
            rotationX = 0;
            rotationY = 0;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) 
              ..rotateX(rotationX)
              ..rotateY(rotationY),
            alignment: FractionalOffset.center,
            child: _buildCreditCard(),
          ),
        ),
      ),
    );
  }

  
  Widget _buildCreditCard() {
    return Container(
      height: 220,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.contactless, color: Colors.white, size: 30),
                    Text("PREMIUM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text(
                  "4521  8832  0094  1245",
                  style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CARD HOLDER", style: TextStyle(color: Colors.white54, fontSize: 10)),
                        Text("FLUTTER DEV", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png',
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}