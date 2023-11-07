

import 'package:agendfael/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:agendfael/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:agendfael/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:agendfael/src/constants/colors.dart';
import 'package:agendfael/src/constants/image_strings.dart';
import 'package:agendfael/src/constants/sizes.dart';
import 'package:agendfael/src/constants/text_strings.dart';
import 'package:agendfael/src/features/authentication/screens/login/login_screen.dart';
import 'package:agendfael/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();


    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;


    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Stack(
        children: [
         TFadeInAnimation(
          durationInMs: 1200,
          animate: TAnimatePosition(
            bottomAfter: 0, 
            bottomBefore: -100,
            leftBefore: 0,
            leftAfter: 0,
            topAfter: 0,
            topBefore: 0,
            rightAfter: 0,
            rightBefore: 0,

            ),
           child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                
                Image(image: AssetImage(tWelcomeScreenImage),height: height * 0.6,),
                
                Row(
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(()=> const LoginScreen()), 
                        child: Text(tLogin.toUpperCase()),
                        ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(()=> const SignUpScreen()), 
                        child: Text(tSignup.toUpperCase()),
                        ),
                    ),  
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                )
              ],
            ),
                 ),
         ),
        ]
      ),
    );
  }
}