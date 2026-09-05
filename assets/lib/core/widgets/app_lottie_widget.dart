// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:portfolio/core/theme/app_theme.dart'; // مسار ملف الثيم الخاص بك

// // class WaveBackgroundWrapper extends StatelessWidget {
// //   final Widget child;

// //   const WaveBackgroundWrapper({super.key, required this.child});

// //   @override
// //   Widget build(BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;

// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       body: Stack(
// //         children: [
// //           // 1️⃣ خلفية التدرج الناعم المعتمدة في مشروعك
// //           Container(
// //             decoration: BoxDecoration(
// //               gradient: isDark ? AppTheme.darkGradient : AppTheme.lightGradient,
// //             ),
// //           ),

// //           // 2️⃣ أنيميشن Wave Loop مع تدرج شفافية لإدمام مظهر الزجاج الساحر
// //           Positioned.fill(
// //             child: Opacity(
// //               opacity: isDark
// //                   ? 0.30
// //                   : 0.18, // 👈 درجة شفافية خفيفة لمنع تشتيت القارئ
// //               child: ShaderMask(
// //                 shaderCallback: (rect) {
// //                   return const LinearGradient(
// //                     begin: Alignment.topCenter,
// //                     end: Alignment.bottomCenter,
// //                     colors: [
// //                       Colors.black,
// //                       Colors.transparent, // تلاشي الأنيميشن تدريجياً في الأسفل
// //                     ],
// //                     stops: [0.6, 1.0],
// //                   ).createShader(rect);
// //                 },
// //                 blendMode: BlendMode.dstIn,
// //                 child: Lottie.asset(
// //                   'assets/lottie/wave_loop.json', // 👈 قم بالتأكد من مطابقة اسم الملف في مجلد الـ assets
// //                   fit: BoxFit.cover,
// //                   repeat: true,
// //                   alignment: Alignment.center,
// //                   errorBuilder: (context, error, stackTrace) {
// //                     return const SizedBox.shrink();
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // 3️⃣ المحتوى الأساسي للصفحة (يعلو خلفية الموجات)
// //           SafeArea(child: child),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class WaveBackgroundWrapper extends StatelessWidget {
//   final Widget child;

//   const WaveBackgroundWrapper({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           // 2️⃣ أنيميشن Lottie مع إعطاء حجم مخصص لتفادي الاختفاء
//           Positioned.fill(
//             child: Opacity(
//               opacity: isDark
//                   ? 0.05
//                   : 0.001, // زيادة الشفافية قليلاً ليصبح مرئياً
//               child: Lottie.asset(
//                 'assets/lottie/wave_loop.json.json', // 👈 أعد تسمية ملف الـ JSON إلى wave_loop.json لتفادي مشاكل المسافات
//                 fit: BoxFit.cover,
//                 repeat: true,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         'خطأ في تحميل Lottie:\n$error',
//                         style: const TextStyle(color: Colors.red),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // 3️⃣ المحتوى فوق الخلفية
//           SafeArea(child: child),
//         ],
//       ),
//     );
//   }
// }
