import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_view/login_view.dart';

class HomeBarbeiro extends StatelessWidget {
  HomeBarbeiro({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tela Barbeiro'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo, Barbeiro!'),
      ),
    );
  }
}
