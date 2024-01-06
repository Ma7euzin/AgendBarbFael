import 'package:agendfael/views/home_view/home_admin.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controller/auth_cotroller.dart';
import '../../res/components/custom_buttom.dart';
import '../../res/components/custom_textfield.dart';

class TelaCadastroBarbeiro extends StatelessWidget {

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
                      title: AppStrings.cadastroBarbeiro,
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
                      hint: AppStrings.fullNameBarbeiro,
                      textControlller: controller.fullnameController,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.emailBarbeiro,
                      textControlller: controller.emailController,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.SenhaDoBarbeiro,
                      textControlller: controller.passwordController,
                    ),
                    20.heightBox,
                    //widget do botão que foi criado
                    CustomButtom(
                      onTap: () async{
                        await controller.signupUserBarber();
                        if(controller.userCredential != null){
                          Get.offAll(() => TelaAdmin());
                        }
                      },
                      buttonText: AppStrings.signupBarbeiro,
                    ),
                    20.heightBox,
                    
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