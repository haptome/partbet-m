import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/config/app_assets.dart';
import '../../core/config/app_color.dart';
import '../../core/config/app_sizes.dart';

class AuthBackground extends StatelessWidget {

  const AuthBackground({required this.child, super.key, this.padding = AppSizes.splashPadding});
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) =>  Scaffold(
    body: Stack(
        children: [
          // Background pattern with circular gradient overlay
          SizedBox.expand(
            child: Stack(
              children: [
                Positioned.fill(
                  child: FadeInImage(
                    placeholder: AssetImage(AppAssets.authPattern),
                    image: AssetImage(AppAssets.authPattern),
                    repeat: ImageRepeat.repeat,
                    width: double.infinity,
                    height: double.infinity,
                    fadeInDuration: const Duration(milliseconds: 1),
                    color: Colors.black.withOpacity(0.9),
                    colorBlendMode: BlendMode.difference,
                  ),
                ),
                // Positioned.fill(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       gradient: RadialGradient(
                //         center: Alignment.topCenter,
                //         radius: 1.4,
                //         colors: <Color>[
                //           const Color.fromARGB(255, 119, 63, 0).withOpacity(0.1),
                //           AppColors.textPrimary.withOpacity(0.1),
                //           AppColors.textPrimary.withOpacity(0.1),
                //         ],
                //         stops: const [0.0, 0.6, 1.0],
                //       ),
                //     ),
                //   ),
                // ),
                Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2B1A0F).withOpacity(0.7),
                    Color(0xFF18100B).withOpacity(0.7),
                  ],
                ),
              ),
            ),
              ],
            ),
          ),
          Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: child,
          )
        ],
      ),
  );
}
