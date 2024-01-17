import 'package:agendfael/views/Users_view/clientes/Tela_Lista_servicos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../consts/consts.dart';

class TelaListaBarbeirosCli extends StatelessWidget {
  const TelaListaBarbeirosCli({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Lista de Barbeiros Disponiveis'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('barbeiros').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os barbeiros'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum barbeiro cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot barbeiro = snapshot.data!.docs[index];
                String nomeBarbeiro = barbeiro['fullname'];
                String emailBarbeiro = barbeiro['email'];
                return ListTile(
                  title: Text(nomeBarbeiro),
                  subtitle: Text(emailBarbeiro),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaServicosCli(barbeiro: barbeiro),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}