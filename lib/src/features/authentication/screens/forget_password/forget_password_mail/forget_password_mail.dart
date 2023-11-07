import 'package:agendfael/src/common_widgets/form/form_header_widget.dart';
import 'package:agendfael/src/constants/image_strings.dart';
import 'package:agendfael/src/constants/sizes.dart';
import 'package:agendfael/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:  Column(
              children: [
                const SizedBox(
                  height: tDefaultSize * 4,
                ),
                const FormHeaderWidget(
                  image: tWelcomeScreenImage, 
                  title: tForgetPassword, 
                  subtitle: tForgetPasswordsubtitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: tFormHeight,),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(tEmail),
                            hintText: tEmail
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){}, 
                            child: Text(tNext)
                            ),
                        )
                      ],
                    )
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}