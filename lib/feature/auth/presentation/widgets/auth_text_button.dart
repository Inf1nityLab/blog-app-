import 'package:blog_app_clean_architecture/core/theme/app_palete.dart';
import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final Widget screen;
  const AuthTextButton({super.key, required this.text, required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: RichText(
        text: TextSpan(
            text: 'Don\'t have an account? ',
            style: const TextStyle(
                color: AppPallete.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 18),
            children: [
              TextSpan(text: text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppPallete.gradient1),)
            ]),
      ),
    );
  }
}

// class AuthTextButtonWidget extends StatelessWidget {
//   final String text;
//   final Widget screen;
//   const AuthTextButtonWidget({super.key, required this.text, required this.screen});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> screen));
//       },
//       child: RichText(
//         text:  TextSpan(
//           text: 'Don\'t  have an account?  ',
//           style: const TextStyle(
//               color: AppPallete.whiteColor,
//               fontWeight: FontWeight.w500,
//               fontSize: 18),
//           children: [
//             TextSpan(
//               text: text,
//               style: const TextStyle(
//                   color: AppPallete.gradient2,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
