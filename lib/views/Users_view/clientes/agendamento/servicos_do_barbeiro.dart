// ignore_for_file: deprecated_member_use

import 'package:agendfael/views/Users_view/clientes/agendamento/Tela_agendamento_dia_hora.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../consts/consts.dart';

class ServicosClientes extends StatefulWidget {
  final DocumentSnapshot barbeiro;

  const ServicosClientes({Key? key, required this.barbeiro}) : super(key: key);

  @override
  State<ServicosClientes> createState() => _ServicosClientesState();
}

class _ServicosClientesState extends State<ServicosClientes>
    with SingleTickerProviderStateMixin {

   

  late TabController _tabController;
  int duracaoTotal = 0;
  double valorTotal = 0;
  List<String> servicosSelecionados = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 1);
  }

  @override
  Widget build(BuildContext context) {

    String barberName = widget.barbeiro['fullname'];
    String barberEmail = widget.barbeiro['email'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 20),
            Text(
              "Serviços",
              style: Theme.of(context).textTheme.headline6,
            ),
            /*IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),*/
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.fromLTRB(40, 20, 40, 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            color: Colors.black,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Column(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 48.0,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    barberName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    barberEmail,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                370, // Adjust the height as needed
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Colors.black,
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black87,
                automaticallyImplyLeading: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                title: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 1,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  controller: _tabController,
                  indicatorColor: Colors.grey,
                  tabs: const <Widget>[
                    Tab(
                        child:
                            Text("Serviços", style: TextStyle(fontSize: 20))),
                  ],
                ),
              ),
              body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('servicos')
                    .where('barbeiroId', isEqualTo: widget.barbeiro.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erro ao carregar os serviços'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('Nenhum serviço disponível'));
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                      ),
                      child: ListView.builder(
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
                              title: AppStyles.normal(
                                  title: nomeServico.toUpperCase(),
                                  color: AppColors.whiteColor,
                                  size: AppSizes.size16),
                              subtitle: Text(
                                'Valor: $valorServico Reais - Duração: $minutosServico minutos',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
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
                      ),
                    );
                  }
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (servicosSelecionados.isNotEmpty) {
                    // Navegar para a próxima tela passando os serviços selecionados
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgendDiaHora(
                          barbeiroSelecionado: widget.barbeiro,
                          servicosSelecionados: servicosSelecionados,
                          duracaoTotal:
                              duracaoTotal, // Passa a duração total para a próxima tela
                          valorTotal:
                              valorTotal, // Passa o valor total para a próxima tela
                        ),
                      ),
                    );
                  } else {
                    // Exibir um aviso ao usuário para selecionar pelo menos um serviço
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Selecione pelo menos um serviço!')),
                    );
                  }
                },
                child: const Icon(Icons.arrow_forward),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Duração Total: $duracaoTotal minutos'),
                      Text('Valor Total: $valorTotal'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
