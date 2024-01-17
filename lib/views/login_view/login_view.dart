// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/controller/auth_cotroller.dart';
import 'package:agendfael/res/components/custom_buttom.dart';
import 'package:agendfael/res/components/custom_textfield.dart';

import 'package:agendfael/views/home_view/home_admin.dart';
import 'package:agendfael/views/home_view/home_barbeiro.dart';
import 'package:agendfael/views/Users_view/clientes/Tela_Lista_servicos.dart';
import 'package:agendfael/views/home_view/home_cliente.dart';
import 'package:agendfael/views/signup_view/signup_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var controller = Get.put(AuthController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  bool isClientSelected = true;
  bool isBarberSelected = false;
  bool isAdminSelected = false;

  void login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: controller.emailController.text,
          password: controller.passwordController.text);

      if (isAdminSelected) {
        DocumentSnapshot snapshot = await _firestore
            .collection('admin')
            .doc(userCredential.user!.uid)
            .get();

        if (snapshot.exists) {
          Get.to(() => TelaAdmin());
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Você não tem permissão de admin.')),
          );
        }
      } else if (isClientSelected) {
        DocumentSnapshot snapshot = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
        // Lógica para login do cliente

        if(snapshot.exists){
          await controller.loginUser();
        if (controller.userCredential != null) {
          Get.to(() => const HomeView());
        }
        //print('Login como Cliente');
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não há nenhum cliente com essa Conta')),
          );
        }
        
      } else if (isBarberSelected) {
        // Lógica para login do barbeiro
        DocumentSnapshot snapshot = await _firestore
            .collection('barbeiros')
            .doc(userCredential.user!.uid)
            .get();
        // Lógica para login do cliente

        if(snapshot.exists){
          await controller.loginUser();
        if (controller.userCredential != null) {
          Get.to(() => HomeBarbeiro());
        }
        //print('Login como Cliente');
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não há nenhum Barbeiro com essa Conta')),
          );
        }
        //print('Login como Barbeiro');
      }
      // Navegação para a tela de barbeiros
      else {
        // Nenhum tipo selecionado
        //print('Selecione um tipo de usuário');
      }
    } catch (e) {
      //
    }
  }

  void signup() {
    if (isClientSelected) {
      Get.to(() => const SignupView());
    } else if (isBarberSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Apenas Admin pode fazer cadastros de barbeiros'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () {
              // Ação ao fechar a mensagem, se desejado
            },
          ),
        ),
      );
    } else if (isAdminSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ops... você não pode se cadastrar'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () {
              // Ação ao fechar a mensagem, se desejado
            },
          ),
        ),
      );
    } else {
      // Nenhum tipo selecionado
      
    }
  }

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
                children: <Widget>[
                  Image.asset(
                    AppAssets.imgWelcome,
                    width: 300,
                  ),
                  10.heightBox,
                  AppStyles.bold(
                      title: AppStrings.welcomeBack, size: AppSizes.size18),
                  AppStyles.bold(title: AppStrings.weAreExcited),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: isClientSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isClientSelected = newValue!;
                              isBarberSelected = false;
                              isAdminSelected = false;
                            });
                          },
                        ),
                        Text(
                          AppStrings.clienteSelecionado,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Checkbox(
                          value: isBarberSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isClientSelected = false;
                              isBarberSelected = newValue!;
                              isAdminSelected = false;
                            });
                          },
                        ),
                        Text(
                          AppStrings.barbeiroSelecionado,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Checkbox(
                          value: isAdminSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isClientSelected = false;
                              isBarberSelected = false;
                              isAdminSelected = newValue!;
                            });
                          },
                        ),
                        Text(
                          AppStrings.adminSelecionado,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
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
                      textControlller: controller.emailController,
                    ),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.password,
                      textControlller: controller.passwordController,
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.normal(title: AppStrings.forgetPassword),
                    ),
                    20.heightBox,
                    //Botão para Login
                    CustomButtom(
                      onTap: () {
                        login(context);
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
                            signup();
                          },
                          child: AppStyles.bold(
                              title: AppStrings.signup, size: AppSizes.size18),
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
