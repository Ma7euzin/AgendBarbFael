import 'package:agendfael/model/agendamentos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendamentoClientes extends StatefulWidget {
  const AgendamentoClientes({super.key});

  @override
  State<AgendamentoClientes> createState() => _AgendamentoClientesState();
}

class _AgendamentoClientesState extends State<AgendamentoClientes> {
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
        title: const Center(child: Text('Meus Agendamentos')),
      ),
      body: agendamentos.isEmpty || _todosAgendamentosPassados()
          ? const Center(
              child: Text('Não há Agendamentos'),
            )
          : ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                Agendamento agendamento = agendamentos[index];
                List<String> servicos = agendamento.servicosSelecionados.split(', ');

                // Use a classe DateFormat para formatar a data
                String dataFormatada = DateFormat('dd/MM/yyyy').format(
                  DateFormat('yyyy-MM-dd').parse(agendamento.dataAgendamento),
                );

                // Verifique se a data do agendamento é futura
                if (isDataFutura(agendamento.dataAgendamento)) {
                  // Utilize ícones de acordo com o status
                  Icon statusIcon = agendamento.confirmado
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.warning, color: Colors.red);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.black12,
                      child: ListTile(
                        title: Text('Barbeiro: ${agendamento.nomeBarbeiro}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data: $dataFormatada - Horário: ${agendamento.horarioAgendamento}',

                            ),
                            Text('Serviços: ${servicos.join(', ')}'),  
                          ],
                        ),
                        trailing: statusIcon,
                      ),
                    ),
                  );
                } else {
                  // Não mostra agendamento passado
                  return Container();
                }
              },
            ),
    );
  }

  bool _todosAgendamentosPassados() {
    final DateTime agora = DateTime.now();
    return agendamentos.every((agendamento) {
      final DateTime dataAgendamento =
          DateFormat('yyyy-MM-dd').parse(agendamento.dataAgendamento);
      return agora.isAfter(dataAgendamento);
    });
  }

  // Função para verificar se a data é futura
  bool isDataFutura(String dataAgendamento) {
    DateTime dataAtual = DateTime.now();
    DateTime dataAgendamentoDt =
        DateFormat('yyyy-MM-dd').parse(dataAgendamento);

    return dataAgendamentoDt.isAfter(dataAtual);
  }

  Future<List<Agendamento>> obterAgendamentosDoUsuario(String usuarioId) async {
    try {
      CollectionReference agendamentosCollection =
          FirebaseFirestore.instance.collection('agendamentos');

      QuerySnapshot<Object?> snapshot = await agendamentosCollection
          .where('usuarioId', isEqualTo: usuarioId)
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


