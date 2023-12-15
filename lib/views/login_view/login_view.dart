import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/res/components/custom_textfield.dart';
import 'package:agendfael/views/home_view/home.dart';
import 'package:agendfael/views/home_view/home_view.dart';
import 'package:agendfael/views/signup_view/signup_view.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgWelcome,
                    width: 300,
                  ),
                  10.heightBox,
                  AppStyles.bold(
                      title: AppStrings.welcomeBack, size: AppSizes.size18),
                  AppStyles.bold(title: AppStrings.weAreExcited),
                  //AppStrings.welcomeBack.text.make(),
                  //AppStrings.weAreExcited.text.make(),
                ],
              ),
            ),
            Expanded(
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    //widgets de customText que foi criado
                    CustomTextField(
                      hint: AppStrings.email,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.password,
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.normal(title: AppStrings.forgetPassword),
                    ),
                    20.heightBox,
                    //widget do botão que foi criado
                    CustomButtom(
                      onTap: () {
                        Get.to(()=>const Home());
                      },
                      buttonText: AppStrings.login,
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.dontHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.to(()=> const SignupView());
                          },
                          child: AppStyles.bold(title: AppStrings.signup, size: AppSizes.size18),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
