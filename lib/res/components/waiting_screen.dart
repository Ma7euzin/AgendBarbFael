// ignore_for_file: unrelated_type_equality_checks, unused_local_variable

import 'package:agendfael/views/Users_view/clientes/Tela_Lista_servicos.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/home_view/home_admin.dart';
import '../../views/home_view/home_barbeiro.dart';
import '../../views/home_view/home_cliente.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    verificarPrimeiraVez();
  }

  Future<void> verificarPrimeiraVez() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool primeiraVez = prefs.getBool('primeira_vez') ?? true;

    User? user = _auth.currentUser;

    if (user != null && !primeiraVez) {
      verificarTipoUsuario();
    } else {
      prefs.setBool('primeira_vez', false);
      redirecionarParaTelaDeLogin();
    }
  }

  void redirecionarParaTelaDeLogin() {
    // Redirecionar para a tela de login
    Get.to(() => const LoginView());
  }

  Future<void> verificarTipoUsuario() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      
      DocumentSnapshot userSnapshot =
          await _firestore.collection('barbeiros').doc(user.uid).get();
      if(user.uid == 'vEZajcUKHqaeItUY3DdJI8eOXun1'){
      Get.to(() => TelaAdmin());
      }else
      if (userSnapshot.exists) {
        dynamic userData = userSnapshot.data();

        if (userData != null && userData is Map<String, dynamic>) {
          bool userType = userData['barb'];
          if (userType == true) {
            Get.to(() => HomeBarbeiro());
          } 
        }
      }
      else{
        Get.to(() => const HomeView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
