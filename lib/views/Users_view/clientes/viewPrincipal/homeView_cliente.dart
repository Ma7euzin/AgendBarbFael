import 'package:agendfael/views/Users_view/clientes/agendamento/tela_lista_barbeiros.dart';
import 'package:agendfael/views/login_view/login_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewCliente extends StatefulWidget {
  const HomeViewCliente({super.key});

  @override
  State<HomeViewCliente> createState() => _HomeViewClienteState();
}

class _HomeViewClienteState extends State<HomeViewCliente> {

  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    void _logout(BuildContext context) async {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView())); 
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        
      ),
      body: Column(
        children: [
          //Banners que o admin adicionar
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('banners').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<String> bannersUrls = snapshot.data!.docs
                      .map((doc) => doc['imagemUrl'] as String)
                      .toList();
                  // Verifica se há mais de uma imagem
                  if (bannersUrls.length > 1) {
                    return CarouselSlider(
                      items: bannersUrls.map((imageUrl) {
                        return Image.network(imageUrl);
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                      ),
                    );
                  } else {
                    // Se houver apenas uma imagem, não inicia o autoPlay
                    return Padding(
                      
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(bannersUrls.first),
                    );
                  }
                } else {
                  return Padding(
                      
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/welcome-screen-image.png'),
                    );
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          //Botão para agendamento
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaListaBarbeirosCli(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Cor de fundo
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Ajusta o tamanho do botão
              ),
              
              child: const Text(
                'AGENDAR',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontWeight: FontWeight.bold, // Negrito
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}