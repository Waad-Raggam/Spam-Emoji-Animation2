import 'package:flutter/material.dart';
import 'package:flutter_animation_sample_1/emoji_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmojiAnimationScreen(),
    );
  }
}

// class ExplosionScreen extends StatefulWidget {
//   @override
//   _ExplosionScreenState createState() => _ExplosionScreenState();
// }

// class _ExplosionScreenState extends State<ExplosionScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   List<Widget> _explosionParticles = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..forward();

//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _explosionParticles.clear();
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _addExplosionParticle() {
//     final random = Random();
//     final particleSize = random.nextDouble() * 40 + 10;
//     final particle = Positioned(
//       left: random.nextDouble() * MediaQuery.of(context).size.width,
//       top: random.nextDouble() * MediaQuery.of(context).size.height,
//       child: Container(
//         width: particleSize,
//         height: particleSize,
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//     setState(() {
//       _explosionParticles.add(particle);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: () {
//           _addExplosionParticle();
//         },
//         child: Stack(
//           children: [
//             AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 double scale = 1.0 + (_animation.value * 0.5);
//                 return Transform.scale(
//                   scale: scale,
//                   child: child,
//                 );
//               },
//               child: Container(),
//             ),
//             Stack(
//               children: _explosionParticles,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
