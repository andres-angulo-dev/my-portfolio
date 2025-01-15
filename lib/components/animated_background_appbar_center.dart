// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class AnimatedBackgroundVideo extends StatefulWidget {
//   const AnimatedBackgroundVideo({ super.key });

//   @override
//   State<AnimatedBackgroundVideo> createState() => _AnimatedBackgroundVideoState();
// }

// class _AnimatedBackgroundVideoState extends State<AnimatedBackgroundVideo> {
//   late VideoPlayerController _controller;
//   late final mobile = VideoPlayerController.asset('assets/video.mp4');
//   late final web = VideoPlayerController.networkUrl(Uri.parse( 'https://dl.dropboxusercontent.com/scl/fi/h1k81c6526wbfqs721nqy/video.mp4?rlkey=21o9azr66lg25tuhvudol9wg8&st=3wnnyce9&raw=1'));
//   // late final web = VideoPlayerController.network('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');

//   @override
//   void initState() {
//     super.initState();

//     _controller = kIsWeb ? web : mobile 
//       ..initialize().then((_) {
//         _controller.setLooping(true);
//         // _controller.play();
//         setState(() {});
//       });
    
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(),
//     );
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class AnimatedBackgroundVideo extends StatefulWidget {
//   const AnimatedBackgroundVideo({super.key});

//   @override
//   State<AnimatedBackgroundVideo> createState() => _AnimatedBackgroundVideoState();
// }

// class _AnimatedBackgroundVideoState extends State<AnimatedBackgroundVideo> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   Future<void> _initializeVideo() async {
//     late final VideoPlayerController mobile = VideoPlayerController.asset('assets/video.mp4');
//     late final VideoPlayerController web = VideoPlayerController.networkUrl(Uri.parse( 'https://dl.dropboxusercontent.com/scl/fi/h1k81c6526wbfqs721nqy/video.mp4?rlkey=21o9azr66lg25tuhvudol9wg8&st=3wnnyce9&raw=1'));

//     _controller = kIsWeb ? web : mobile;

//     try {
//       await _controller.initialize();
//       _controller.setLooping(true);
//       _controller.play();
//       setState(() {
//         _isInitialized = true;
//       });
//       print("Video initialized and playing.");
//     } catch (e, s) {
//       print("Error initializing video: $e\n$s");
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Not full screen but display video OK
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _errorMessage != null
//           ? Text("Failed to load video: $_errorMessage")
//           : _isInitialized && kIsWeb
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(), //CircularProgressIndicator(),
//     );
//   }

//   // // full screen display video ko
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Center(
//   //     child: _errorMessage != null
//   //       ? Text("Failed to load video: $_errorMessage")
//   //       : _isInitialized
//   //           ? Stack(
//   //               children: [
//   //                 Center(
//   //                   child: AspectRatio(
//   //                     aspectRatio: _controller.value.aspectRatio,
//   //                     child: VideoPlayer(_controller),
//   //                   ),
//   //                 ),
//   //                 Positioned.fill(
//   //                   child: FittedBox(
//   //                     fit: BoxFit.cover,
//   //                     child: SizedBox(
//   //                       width: _controller.value.size?.width ?? 0,
//   //                       height: _controller.value.size?.height ?? 0,
//   //                       child: VideoPlayer(_controller),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             )
//   //           : null,
//   //   );
//   // }
// }

// // Full screen displaye video OK
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class AnimatedBackgroundVideo extends StatefulWidget {
//   const AnimatedBackgroundVideo({ super.key });

//   @override
//   State<AnimatedBackgroundVideo> createState() => _AnimatedBackgroundVideoState();
// }

// class _AnimatedBackgroundVideoState extends State<AnimatedBackgroundVideo> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   Future<void> _initializeVideo() async {
//     late final VideoPlayerController mobile = VideoPlayerController.asset('assets/video.mp4');
//     // late final VideoPlayerController web = VideoPlayerController.networkUrl(Uri.parse( 'https://dl.dropboxusercontent.com/scl/fi/27sxaoxwynhfj5vdqkdi8/video.mp4?rlkey=1pcr4komaipr9xbogj20b4byq&st=ne0neuja&dl=0&raw=1'));
//     late final VideoPlayerController web = VideoPlayerController.networkUrl(Uri.parse( 'https://www.canva.com/design/DAGcCZAm1dE/4sWEVesV42voYwlEqlTdvQ/watch'));

//     _controller = kIsWeb ? web : mobile;

//     try {
//       await _controller.initialize();
//       _controller.setLooping(true);
//       // _controller.play();
//       setState(() {
//         _isInitialized = true;
//       });

//       //force play if encountered error (manual retry) 
//       await Future.delayed(Duration(seconds: 5)); 
//       _controller.play(); // Retry 
//       print("Autoplay attempted again.");
//       print("Video initialized and playing.");
//     } catch (e, s) {
//       print("Error initializing video: $e\n$s");
//       setState(() {
//         _errorMessage = e.toString();
//       });


//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _errorMessage != null
//         ? Text("Failed to load video: $_errorMessage")
//         : _isInitialized && kIsWeb
//             ? Stack(
//                 children: [
//                   Center(
//                     child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     ),
//                   ),
//                   Positioned.fill(
//                     child: FittedBox(
//                       fit: BoxFit.cover,
//                       child: SizedBox(
//                         width: _controller.value.size?.width ?? 0,
//                         height: _controller.value.size?.height ?? 0,
//                         child: VideoPlayer(_controller),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             : Container(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedBackgroundAppBarCenter extends StatelessWidget {
  const AnimatedBackgroundAppBarCenter({ super.key });
  
  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final web = Image.asset('assets/animation_web.gif');
  final mobile = Image.asset('assets/animation_mobile.gif');

    return Center(
      child: screenWidth < 1620 ? mobile : web,
    );
  }
}
