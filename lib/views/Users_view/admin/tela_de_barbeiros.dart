// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/views/Users_view/admin/Tela_sobre_barbeiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TelaListaBarbeiros extends StatefulWidget {
  const TelaListaBarbeiros({super.key});

  @override
  _TelaListaBarbeirosState createState() => _TelaListaBarbeirosState();
}

class _TelaListaBarbeirosState extends State<TelaListaBarbeiros> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _excluirBarbeiro(String barbeiroId) async {
    try {
      // Obtém a referência para o documento a ser excluído
      final docRef = _firestore.collection('barbeiros').doc(barbeiroId);

      // Verifica quantos documentos existem na coleção
      final docsSnapshot = await _firestore.collection('barbeiros').get();
      final numberOfDocs = docsSnapshot.docs.length;

      if (numberOfDocs > 1) {
        // Exclui o documento apenas se houver mais de um documento restante na coleção
        await docRef.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Barbeiro excluído com sucesso!')),
        );
      } else {
        // Se for o último documento, informa ao usuário que pelo menos um barbeiro deve ser mantido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deve haver pelo menos um barbeiro!')),
        );
      }
    } catch (error) {
      //print('Erro ao excluir o barbeiro: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir o barbeiro. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Barbeiros'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('barbeiros').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Sem barbeiros cadastrados.'),
            );
          }

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.black),
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaEditarBarbeiro(
                                      barbeiro: data,
                                      barbeiroId: document.id,
                                    )),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            child: Image.asset(
                              AppAssets.imgUser,
                            ),
                          ),
                          title: Text(data['fullname'] ?? ''),
                          subtitle: Text(data['email'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmar exclusão'),
                                        content: const Text(
                                            'Tem certeza que deseja excluir este barbeiro?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _excluirBarbeiro(document.id);
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
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
