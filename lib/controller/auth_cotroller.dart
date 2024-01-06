// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'package:agendfael/consts/consts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;

  loginUser() async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  loginAdmin() async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  signupUser() async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    await storeUserData(userCredential!.user!.uid, fullnameController.text,
        emailController.text, false);
  }

  //somente admin poderar acessar esse campo
  signupUserBarber() async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    await storeUserBarberData(userCredential!.user!.uid,
        fullnameController.text, emailController.text, true, '','','',0,'');
  }

  storeUserBarberData(
      String uid,
      String fullname,
      String email,
      bool barb,
      String horaioBarb,
      String sobreBarb,
      String enderecoBarb,
      int estrelas,
      String celularBarb) async {
    var store = FirebaseFirestore.instance.collection('barbeiros').doc(uid);
    await store.set({
      'fullname': fullname,
      'email': email,
      'barb': barb,
      'horarioBarb': horaioBarb,
      'sobreBarb': sobreBarb,
      'enderecoBarb': enderecoBarb,
      'estrelas': estrelas,
      'celularBarb': celularBarb
    });
  }

  storeUserData(String uid, String fullname, String email, bool admin) async {
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store.set({
      'fullname': fullname,
      'email': email,
      'admin': admin,
    });
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
