

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../consts/consts.dart';

import 'package:intl/intl.dart';

class TelaAgendamento extends StatelessWidget {
   const TelaAgendamento({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('agendamentos').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os agendamentos'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum agendamento encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot agendamento = snapshot.data!.docs[index];
                String cliente = agendamento['cliente'];
                String servico = agendamento['servico'];
                DateTime horario = (agendamento['horario'] as Timestamp).toDate();

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Cliente: $cliente'),
                    subtitle: Text('Serviço: $servico\nHorário: ${DateFormat('dd/MM/yyyy HH:mm').format(horario)}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implemente a lógica para confirmar o agendamento
                        _confirmarAgendamento(agendamento);
                      },
                      child: const Text('Confirmar'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

   void _confirmarAgendamento(DocumentSnapshot agendamento) {
    // Implemente a lógica para confirmar o agendamento
    // Por exemplo, atualizar o status do agendamento no Firestore
    FirebaseFirestore.instance.collection('agendamentos').doc(agendamento.id).update({
      'confirmado': true,
    });
  }

}