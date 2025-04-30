// import 'package:flutter/material.dart';
//
// class LoadingScreen extends StatefulWidget {
//   const LoadingScreen({super.key});
//
//   @override
//   State<LoadingScreen> createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildFadingCircle(Colors.blue),
//         _buildFadingCircle(Colors.green),
//         _buildFadingCircle(Colors.red),
//       ],
//     );
//   }
//   Widget _buildFadingCircle(Color color) {
//     return AnimatedOpacity(
//       opacity: 1.0,
//       duration: Duration(seconds: 1),
//       curve: Curves.easeInOut,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
//   }
//
