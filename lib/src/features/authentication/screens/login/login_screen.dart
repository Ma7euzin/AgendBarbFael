import 'package:agendfael/src/common_widgets/form/form_header_widget.dart';
import 'package:agendfael/src/constants/image_strings.dart';
import 'package:agendfael/src/constants/sizes.dart';
import 'package:agendfael/src/constants/text_strings.dart';
import 'package:agendfael/src/features/authentication/screens/login/widgets/login_footer_widget.dart';
import 'package:agendfael/src/features/authentication/screens/login/widgets/login_form_widget.dart';
import 'package:agendfael/src/features/authentication/screens/login/widgets/login_header_widget.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage, 
                  title: tLoginTitle,
                  subtitle: tLoginSubTitle,
                  ),
                const LoginForm(),
                const LoginFooterWidget()
                  
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}



