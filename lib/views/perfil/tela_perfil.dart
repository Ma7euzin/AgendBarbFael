// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../consts/consts.dart';

class TelaPerfil extends StatelessWidget {
  TelaPerfil({super.key});

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
        actions: <Widget>[
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome: Barbeiro Fulano',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Email: barbeiro@example.com'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implementar a lógica de edição do perfil
              },
              child: const Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}