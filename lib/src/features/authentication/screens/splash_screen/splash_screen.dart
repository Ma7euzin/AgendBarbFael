import 'package:agendfael/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:agendfael/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:agendfael/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:agendfael/src/constants/image_strings.dart';
import 'package:agendfael/src/constants/sizes.dart';
import 'package:agendfael/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: 0, topBefore: -60, leftBefore: -60, leftAfter: 0
            ),
            child: const Image(image: AssetImage(tSplashTopIcon)),
            
            ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(topBefore: 80, topAfter: 80,leftAfter: tDefaultSize,leftBefore: -80), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tAppName,
                    style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(tAppTagLine,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
          ),
            TFadeInAnimation(
              durationInMs: 2000,
              animate: TAnimatePosition(topBefore: 500, topAfter: 100,leftAfter: 0,leftBefore: 0),
              child: const Positioned(
              bottom: 10,
              child: Padding(
                padding: EdgeInsets.fromLTRB(2, 10, 4, 5),
                child: Image(
                  
                  image: AssetImage(
                    tSplashImage,
                    
                  ),
                ),
              ),
                      ),
            ),
        ],
      ),
    );
  }
  
}