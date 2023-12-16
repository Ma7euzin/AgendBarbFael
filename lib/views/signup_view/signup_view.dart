import 'package:agendfael/controller/auth_cotroller.dart';
import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/res/components/custom_textfield.dart';
import 'package:agendfael/views/home_view/home.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

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
                      title: AppStrings.signupNow,
                      size: AppSizes.size18,
                      alignment: TextAlign.center),
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
                      hint: AppStrings.fullName,
                      textControlller: controller.fullnameController,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.email,
                      textControlller: controller.emailController,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.password,
                      textControlller: controller.passwordController,
                    ),
                    20.heightBox,
                    //widget do botão que foi criado
                    CustomButtom(
                      onTap: () async{
                        await controller.signupUser();
                        if(controller.userCredential != null){
                          Get.offAll(() => const Home());
                        }
                      },
                      buttonText: AppStrings.signup,
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(
                              title: AppStrings.login, size: AppSizes.size18),
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
