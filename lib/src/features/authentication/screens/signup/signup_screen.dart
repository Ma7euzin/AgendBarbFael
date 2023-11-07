
import 'package:agendfael/src/common_widgets/form/form_header_widget.dart';
import 'package:agendfael/src/constants/image_strings.dart';
import 'package:agendfael/src/constants/sizes.dart';
import 'package:agendfael/src/constants/text_strings.dart';
import 'package:agendfael/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const FormHeaderWidget(
                  image: tWelcomeScreenImage, 
                  title: tSignupTitle, 
                  subtitle: tSignupSubTitle,
                  ),
                  const SignUpFormWidget(),
                  Column(
                    children: [
                      const Text("OU"),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: (){}, 
                          icon: const Image(image: AssetImage(tGoogleLogoImage),
                            width: 20.0,
                          ),
                          label: Text(tSignInWithGoogle.toUpperCase()),
                          ),
                      ),
                      TextButton(
                        onPressed: (){}, 
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyText1),
                              TextSpan(text: tLogin.toUpperCase()),
                            ]
                          )
                        )
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

