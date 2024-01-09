// ignore_for_file: file_names, unnecessary_import

import 'package:agendfael/views/Tela%20de%20clientes/tela_detalhes_cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class TelaClientes extends StatefulWidget {
  const TelaClientes({super.key});

  @override
  State<TelaClientes> createState() => _TelaClientesState();
}

class _TelaClientesState extends State<TelaClientes> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes da Barbearia'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
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

          int quantidadeClientes = snapshot.data!.size;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Quantidade de Clientes: $quantidadeClientes"),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.black),
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                    builder: (context) => TelaDetalhesCliente(
                                      cliente: data,
                                    ),
                                  ),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
