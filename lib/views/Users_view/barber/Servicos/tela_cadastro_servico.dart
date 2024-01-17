import 'package:agendfael/model/servicos_model.dart';
import 'package:agendfael/views/Users_view/barber/tela_servi%C3%A7os_barb.dart';
import 'package:agendfael/views/home_view/home_barbeiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../consts/consts.dart';

class TelaCadastrarServico extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _minutosController = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _cadastrarServico() async {
    if (user != null) {
      String nome = _nomeController.text;
      double valor = double.parse(_valorController.text);
      int minutos = int.parse(_minutosController.text);
      String barbeiroId = user!.uid;

      Servico servico = Servico(
        nome: nome,
        valor: valor,
        minutos: minutos,
        barbeiroId: barbeiroId,
      );

      await FirebaseFirestore.instance
          .collection('servicos')
          .doc(nome.toLowerCase())
          .set(servico.toMap());

      _nomeController.clear();
      _valorController.clear();
      _minutosController.clear();
    }
    Get.to(()=> const HomeBarbeiro());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Serviço'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Serviço'),
            ),
            TextFormField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _minutosController,
              decoration: const InputDecoration(labelText: 'Minutos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrarServico,
              child: const Text('Cadastrar Serviço'),
              
              
            ),
          ],
        ),
      ),
    );
  }
}