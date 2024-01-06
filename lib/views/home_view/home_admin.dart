// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/views/Users_view/admin/tela_de_barbeiros.dart';
import 'package:agendfael/views/Users_view/admin/tela_gerenciar_horarios.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../signup_view/signup_barbeiro.dart';

class TelaAdmin extends StatelessWidget {
  TelaAdmin({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()));
  }

  void adicionarBarbeiro(BuildContext context) {
    // Lógica para adicionar barbeiros
    // Isso pode incluir a navegação para uma tela de adicionar barbeiros
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaCadastroBarbeiro()),
    );
    // ou a exibição de um modal ou diálogo para adicionar novos barbeiros
  }

  void horarioBarbearia(BuildContext context) {
    // Lógica para adicionar barbeiros
    // Isso pode incluir a navegação para uma tela de adicionar barbeiros
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaGerenciarHorario()),
    );
    // ou a exibição de um modal ou diálogo para adicionar novos barbeiros
  }

  void verBarbeiros(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaListaBarbeiros()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Bem Vindo Admin'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => adicionarBarbeiro(context),
                child: const Text('Adicionar Barbeiro'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => verBarbeiros(context),
                child: const Text('Ver Barbeiros'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => horarioBarbearia(context),
                child: const Text('Gerenciar Horario de Funcionamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
