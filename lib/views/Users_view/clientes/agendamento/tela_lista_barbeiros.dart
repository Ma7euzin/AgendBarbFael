import 'package:agendfael/views/Users_view/clientes/agendamento/servicos_do_barbeiro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../consts/consts.dart';

class TelaListaBarbeirosCli extends StatelessWidget {
  const TelaListaBarbeirosCli({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Barbeiros Disponíveis'),
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

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.black87,
                    elevation: 3,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images/user.png'), // Replace with actual URL
                      ),
                      title: Text(
                        nomeBarbeiro,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        emailBarbeiro,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ServicosClientes(barbeiro: barbeiro),
                          ),
                        );
                      },
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
}
