// import 'package:sunrise_hosting/gen/assets.gen.dart';
// import 'package:sunrise_hosting/home/home_parent_page.dart';
// import 'package:flutter/material.dart';

// class CircleLoader extends StatefulWidget {
//   final double size;
//   final Color color;

//   const CircleLoader({Key? key, required this.size, required this.color})
//       : super(key: key);

//   @override
//   _CircleLoaderState createState() => _CircleLoaderState();
// }

// class _CircleLoaderState extends State<CircleLoader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3),
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _animationController.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (BuildContext context, Widget? child) {
//         return Container(
//           width: widget.size,
//           height: widget.size,
//           child: Transform.scale(
//             scale: _scaleAnimation.value,
//             child: Image.asset(
//               // Assets.images.babicon.path,
//               color: widget.color,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
