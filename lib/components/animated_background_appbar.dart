// With Lottie widget
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedBackgroundAppbar extends StatefulWidget {
  const AnimatedBackgroundAppbar({ super.key });

  @override
  State<AnimatedBackgroundAppbar> createState() => _AnimatedBackgroundAppbarState();
}

class _AnimatedBackgroundAppbarState extends State<AnimatedBackgroundAppbar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        screenWidth < 768 ?
        Positioned(
          top: 18,
          right: -175,
          child: Lottie.asset(
            "assets/main_scene.json",
            width: 600,
          ),
        )
        :
        Positioned(
          width: screenWidth / 0.595,
          child: Lottie.asset(
            "assets/main_scene.json",
            width: screenWidth,
            height: screenHeight,
          ),
        ),
      ],
    );
  }
}

// // With Animated_background widget
// import 'package:flutter/material.dart';
// import 'package:animated_background/animated_background.dart';
// import '../utils/global_colors.dart';

// class AnimatedBackgroundAppbar extends StatefulWidget {
//   const AnimatedBackgroundAppbar({ super.key });

//   @override
//   State<AnimatedBackgroundAppbar> createState() => _AnimatedBackgroundAppbarState();
// }

// class _AnimatedBackgroundAppbarState extends State<AnimatedBackgroundAppbar> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     // var particlePaint = Paint() 
//     // ..style = PaintingStyle.stroke 
//     // ..strokeWidth = 50.0;

//     return AnimatedBackground(
//       // behaviour: RandomParticleBehaviour(
//       //   options: const ParticleOptions(
//       //     particleCount: 100, // n° of objects in background
//       //     spawnOpacity: 0.1, // handle opacity
//       //     opacityChangeRate: 1.0,
//       //     minOpacity: 0.1,
//       //     maxOpacity: 0.6,
//       //     spawnMinRadius: 10, // min radius of background object
//       //     spawnMaxRadius: 30, // max radius of background object
//       //     spawnMinSpeed: 10, // minimum speed of object moving
//       //     spawnMaxSpeed: 40, // maximum speed of object moving
//       //     baseColor: Colors.black,
//       //     // image: Image(image: AssetImage(AppImages.animatedBackground))
//       //   ),
//       //   // paint: particlePaint,
//       // ),
//       // behaviour: BubblesBehaviour(), // 
//       // behaviour: RacingLinesBehaviour(
//       //   direction: LineDirection.Ltr,
//       //   numLines: 10,
//       // ),
//       // behaviour: RectanglesBehaviour(),
//       behaviour:SpaceBehaviour(
//         backgroundColor: GlobalColors.secondaryBackground,
//       ),
//       vsync: this,
//       child: SizedBox(
//         height: 800,
//         width: 100,
//       ),
//     );
//   }
// }

// // With particles_flutter widget
// import 'package:flutter/material.dart';
// import 'package:particles_flutter/component/particle/particle.dart';
// import 'package:particles_flutter/particles_engine.dart';
// import 'dart:math';

// class AnimatedBackgroundAppbar extends StatelessWidget {
//   const AnimatedBackgroundAppbar({ super.key });

//   List<Particle> createParticles() {
//     var rng = Random();
//     List<Particle> particles = [];
//     for (int i = 0; i < 60; i++) {
//       particles.add(Particle(
//         color: Colors.white.withOpacity(0.6),
//         size: rng.nextDouble() * 10,
//         velocity: Offset(rng.nextDouble() * 200 * randomSign(),
//             rng.nextDouble() * 200 * randomSign()),
//       ));
//     }
//     return particles;
//   }

//   double randomSign() {
//     var rng = Random();
//     return rng.nextBool() ? 1 : -1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTapDown: (details) {
//       },
//       child: MouseRegion(
//         onHover: (event) {
//         },
//         child: Stack(
//           children: [
//             Container(
//               color: Colors.transparent, 
//               child: Particles(
//                 awayRadius: 50,
//                 particles: createParticles(),
//                 height: screenHeight,
//                 width: screenWidth,
//                 onTapAnimation: true,
//                 awayAnimationDuration: const Duration(milliseconds: 2000),
//                 awayAnimationCurve: Curves.linear,
//                 enableHover: true,
//                 hoverRadius: 90,
//                 connectDots: false,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // With Mesh_gradient widget v1
// import 'package:flutter/material.dart';
// import 'package:mesh_gradient/mesh_gradient.dart';

// class AnimatedBackgroundAppbar extends StatefulWidget {
//   const AnimatedBackgroundAppbar({super.key});

//   @override
//   State<AnimatedBackgroundAppbar> createState() => _AnimatedBackgroundAppbarState();
// }

// class _AnimatedBackgroundAppbarState extends State<AnimatedBackgroundAppbar> {
//   int _currentIndex = 1;

//   List<MeshGradientPoint> _generatePoints() {
//     return [
//       MeshGradientPoint(
//         position: const Offset(0.2, 0.2),
//         color: Colors.red,
//       ),
//       MeshGradientPoint(
//         position: const Offset(0.8, 0.2),
//         color: Colors.blue,
//       ),
//       MeshGradientPoint(
//         position: const Offset(0.2, 0.8),
//         color: Colors.green,
//       ),
//       MeshGradientPoint(
//         position: const Offset(0.8, 0.8),
//         color: Colors.yellow,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: _currentIndex == 0
//               ? MeshGradientView(points: _generatePoints()) // Vue MeshGradient statique
//               : AnimatedMeshGradientView(points: _generatePoints()), // Vue MeshGradient animée
//         ),
//       ],
//     );
//   }
// }

// class MeshGradientView extends StatelessWidget {
//   final List<MeshGradientPoint> points;

//   const MeshGradientView({super.key, required this.points});

//   @override
//   Widget build(BuildContext context) {
//     return MeshGradient(
//       points: points,
//       options: MeshGradientOptions(),
//       child: Container(),
//     );
//   }
// }

// class AnimatedMeshGradientView extends StatelessWidget {
//   final List<MeshGradientPoint> points;

//   const AnimatedMeshGradientView({super.key, required this.points});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedMeshGradient(
//       colors: const [
//         Colors.red,
//         Colors.blue,
//         Colors.green,
//         Colors.yellow,
//       ],
//       options: AnimatedMeshGradientOptions(),
//       child: Container(),
//     );
//   }
// }

// With Mesh_gradient widget v2
// import 'package:flutter/material.dart';
// import 'package:mesh_gradient/mesh_gradient.dart';

// class AnimatedBackgroundAppbar extends StatefulWidget {
//   const AnimatedBackgroundAppbar({super.key});

//   @override
//   State<AnimatedBackgroundAppbar> createState() => _AnimatedBackgroundAppbarState();
// }

// class _AnimatedBackgroundAppbarState extends State<AnimatedBackgroundAppbar> with SingleTickerProviderStateMixin {
//   late final MeshGradientController _meshController;
//   late final AnimatedMeshGradientController _animatedMeshController;

//   @override
//   void initState() {
//     super.initState();

//     _meshController = MeshGradientController(
//       points: [
//         MeshGradientPoint(position: const Offset(0.2, 0.6), color: const Color.fromARGB(255, 255, 179, 0)),
//         MeshGradientPoint(position: const Offset(0.4, 0.5), color: const Color.fromARGB(255, 69, 18, 255)),
//         MeshGradientPoint(position: const Offset(0.7, 0.4), color: const Color.fromARGB(255, 0, 255, 198)),
//         MeshGradientPoint(position: const Offset(0.4, 0.9), color: const Color.fromARGB(255, 255, 179, 0)),
//       ],
//       vsync: this,
//     );

//     _animatedMeshController = AnimatedMeshGradientController();

//     // Start the animated gradient controller
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _animatedMeshController.start();
//     });
//   }

//   @override
//   void dispose() {
//     _meshController.dispose();
//     _animatedMeshController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Stack(
//         children: [
//           MeshGradient(
//             controller: _meshController,
//             options: MeshGradientOptions(
//               blend: 5,
//               noiseIntensity: 0.1,
//             ),
//             child: Container(),
//           ),
//           AnimatedMeshGradient(
//             colors: const [
//               Color(0xFFFFB300),
//               // Colors.red,
//               // Colors.blue,
//               Colors.green,
//               Colors.yellow,
//             ],
//             options: AnimatedMeshGradientOptions(
//               speed: 0.5,
//               frequency: 1.0,
//               amplitude: 1.0,
//               grain: 0.1,
//             ),
//             controller: _animatedMeshController,
//             child: Container(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // With Rive widget
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rive/rive.dart' as rive;

// class AnimatedBackgroundAppbar extends StatefulWidget {
//   const AnimatedBackgroundAppbar({ super.key });

//   @override
//   State<AnimatedBackgroundAppbar> createState() => _AnimatedBackgroundAppbarState();
// }

// class _AnimatedBackgroundAppbarState extends State<AnimatedBackgroundAppbar> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {

//     return Stack(
//       children: [
//         // Image.asset("assets/shapes.png"),
//         // Positioned(
//         //   // height: 100,
//         //   width: MediaQuery.of(context).size.width * 0.7,
//         //   bottom: 50,
//         //   left: 800,
//         //   child: Image.asset("assets/shapes.png"),
//         // ),
//         // Positioned.fill(
//         //   child: BackdropFilter(
//         //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
//         //     child: SizedBox(),
//         //   )
//         // ),
//         // rive.RiveAnimation.asset("assets/shapes.riv"),
//         // Positioned.fill(
//         //   child: BackdropFilter(
//         //     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
//         //     child: SizedBox(),
//         //   )
//         // ),
//         // rive.RiveAnimation.asset("assets/works.riv"),
//       ],
//     );
//   }
// }

