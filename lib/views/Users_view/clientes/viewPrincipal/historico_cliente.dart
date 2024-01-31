import 'package:agendfael/model/agendamentos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoricoCliente extends StatefulWidget {
  const HistoricoCliente({Key? key});

  @override
  State<HistoricoCliente> createState() => _AgendamentoClientesState();
}

class _AgendamentoClientesState extends State<HistoricoCliente> {
  List<Agendamento> agendamentos = [];

  @override
  void initState() {
    super.initState();

    // Obtenha a instância do usuário atual
    User? user = FirebaseAuth.instance.currentUser;

    // Verifique se o usuário está logado
    if (user != null) {
      // Use o ID do usuário logado para obter os agendamentos
      obterAgendamentosDoUsuario(user.uid).then((listaAgendamentos) {
        setState(() {
          agendamentos = listaAgendamentos;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Historico de Agendamentos')),
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          Agendamento agendamento = agendamentos[index];
          List<String> servicos = agendamento.servicosSelecionados.split(', ');
          return Card(
            color: Colors.black,
            child: ListTile(
              title: Text('Barbeiro: ${agendamento.nomeBarbeiro}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Data: ${agendamento.dataAgendamento} - Horário: ${agendamento.horarioAgendamento}',),
                  Text('Serviços: ${servicos.join(', ')}'),    
                ],
              ),
              // Adicione mais detalhes conforme necessário
              trailing: agendamento.finalizado
                  ? const Text('finalizado')
                  : const Text('Aguardando confirmação do barbeiro'),
            ),
          );
        },
      ),
    );
  }

  Future<List<Agendamento>> obterAgendamentosDoUsuario(String usuarioId) async {
    try {
      CollectionReference agendamentosCollection =
          FirebaseFirestore.instance.collection('agendamentos');

      QuerySnapshot<Object?> snapshot = await agendamentosCollection
          .where('usuarioId', isEqualTo: usuarioId)
          .where('finalizado', isEqualTo: true)
          .get();

      List<Agendamento> agendamentos = snapshot.docs.map((doc) {
        Map<String, dynamic> data =
            doc.data() as Map<String, dynamic>; // Conversão aqui
        return Agendamento(
          id: doc.id,
          barbeiroId: data['barbeiroId'],
          nomeBarbeiro: data['nomeBarbeiro'],
          servicosSelecionados: data['servicosSelecionados'],
          dataAgendamento: data['dataAgendamento'],
          horarioAgendamento: data['horarioAgendamento'],
          confirmado: data['confirmado'],
          finalizado: data['finalizado'],
        );
      }).toList();

      return agendamentos;
    } catch (error) {
      print("Erro ao obter agendamentos: $error");
      // Lógica de tratamento de erro, se necessário
      return [];
    }
  }
}
