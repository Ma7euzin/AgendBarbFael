// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/views/Users_view/clientes/tela_lista_barbeiros.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Users_view/admin/tela_de_barbeiros.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    void _logout(BuildContext context) async {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sua Aplicação'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TelaListaBarbeirosCli(),
              ),
            );
          },
          child: Text('Agendar Serviço'),
        ),
      ),
    );
  }
}
