// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/consts/consts.dart';
import 'package:agendfael/consts/list.dart';
import 'package:agendfael/views/Users_view/clientes/Tela_agendamento_dia_hora.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../login_view/login_view.dart';

class TelaServicosCli extends StatefulWidget {
  final DocumentSnapshot barbeiro;
  const TelaServicosCli({super.key, required this.barbeiro});

  @override
  State<TelaServicosCli> createState() => _TelaServicosCliState();
}

class _TelaServicosCliState extends State<TelaServicosCli> {
  int duracaoTotal = 0;
  double valorTotal = 0;
  List<String> servicosSelecionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: AppColors.primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: AppStyles.normal(
          title: 'Serviços Disponiveis com Esse Barbeiro',
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('servicos')
            .where('barbeiroId', isEqualTo: widget.barbeiro.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os serviços'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum serviço disponível'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot servico = snapshot.data!.docs[index];
                String nomeServico = servico['nome'];
                double valorServico = servico['valor'];
                int minutosServico = servico['minutos'];

                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 10, bottom: 10),
                  child: CheckboxListTile(
                    /*trailing: Image.asset(
                      IconList[index],
                      scale: 10,
                      color: AppColors.whiteColor,
                    ),*/
                    title: AppStyles.normal(
                        title: nomeServico.toUpperCase(),
                        color: AppColors.whiteColor,
                        size: AppSizes.size34),
                    subtitle: Text(
                      'Valor: $valorServico Reais - Duração: $minutosServico minutos',
                      style: const TextStyle(fontSize: 25),
                    ),
                    value: servicosSelecionados.contains(nomeServico),
                    onChanged: (bool? value) {
                      setState(() {
                      if (value != null && value) {
                        servicosSelecionados.add(nomeServico);
                        duracaoTotal += minutosServico;
                        valorTotal += valorServico;
                      } else {
                        servicosSelecionados.remove(nomeServico);
                        duracaoTotal -= minutosServico;
                        valorTotal -= valorServico;
                      }
                    });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if (servicosSelecionados.isNotEmpty) {
            // Navegar para a próxima tela passando os serviços selecionados
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgendDiaHora(
                  barbeiroSelecionado: widget.barbeiro,
                  servicosSelecionados: servicosSelecionados,
                  duracaoTotal: duracaoTotal, // Passa a duração total para a próxima tela
                  valorTotal: valorTotal, // Passa o valor total para a próxima tela
                ),
              ),
            );
          } else {
            // Exibir um aviso ao usuário para selecionar pelo menos um serviço
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selecione pelo menos um serviço!')),
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Duração Total: $duracaoTotal minutos'),
              Text('Valor Total: $valorTotal'),
            ],
          ),
        ),
      ),
    );
  }

  void _selecionarServico(BuildContext context, DocumentSnapshot servico) {
    // Implemente a lógica para o cliente selecionar o serviço
    // Por exemplo, navegar para a tela de agendamento com o serviço selecionado
  }
}
