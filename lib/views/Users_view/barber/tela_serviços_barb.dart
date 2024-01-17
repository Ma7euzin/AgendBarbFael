import 'package:agendfael/model/servicos_model.dart';
import 'package:agendfael/views/Users_view/barber/Servicos/Tela_editar_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../consts/consts.dart';
import 'Servicos/tela_cadastro_servico.dart';

class TelaServicos extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  TelaServicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Serviços'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('servicos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os serviços'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum serviço cadastrado'));
          } else {
            List<Widget> servicosList = snapshot.data!.docs.map((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String nome = data['nome'];
              double valor = data['valor'];
              int minutos = data['minutos'];

              return ListTile(
                title: Text(nome),
                subtitle: Text('Valor: $valor - Minutos: $minutos'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implementar a lógica para editar o serviço
                        _editarServico(context, document);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Implementar a lógica para deletar o serviço
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar exclusão'),
                              content: const Text(
                                  'Tem certeza que deseja excluir este Serviço?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deletarServico(document);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Excluir'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList();

            return ListView(
              children: [
                ...servicosList,
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaCadastrarServico()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editarServico(BuildContext context, DocumentSnapshot document) {
    // Implementar a tela de edição passando o documento para a próxima tela
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TelaEditarServico(document: document)),
    );
  }

  void _deletarServico(DocumentSnapshot document) {
    // Implementar a lógica para deletar o serviço
    FirebaseFirestore.instance.collection('servicos').doc(document.id).delete();
  }
}
