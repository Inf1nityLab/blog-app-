import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppPallete.whiteColor),
        ),
      ),
    );
  }
}

// final String name = 'Baias';

// class AuthButtonWidget extends StatelessWidget {
//   final String text;
//   final Function() onPressed;
//
//   const AuthButtonWidget(
//       {super.key, required this.text, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: const LinearGradient(colors: [
//             AppPallete.gradient1,
//             AppPallete.gradient2,
//           ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//             backgroundColor: AppPallete.transparentColor,
//             shadowColor: AppPallete.transparentColor),
//         child: Text(
//           text,
//           style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: AppPallete.whiteColor),
//         ),
//       ),
//     );
//   }
// }
