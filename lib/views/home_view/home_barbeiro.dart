// ignore_for_file: use_build_context_synchronously

import 'package:agendfael/views/Users_view/barber/tela_agendamentos_barb.dart';
import 'package:agendfael/views/Users_view/barber/tela_horarios.dart';
import 'package:agendfael/views/Users_view/barber/tela_perfil_barb.dart';
import 'package:agendfael/views/Users_view/barber/tela_servi%C3%A7os_barb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_view/login_view.dart';

class HomeBarbeiro extends StatefulWidget {
  const HomeBarbeiro({super.key});

  @override
  State<HomeBarbeiro> createState() => _HomeBarbeiroState();
}

class _HomeBarbeiroState extends State<HomeBarbeiro> {
  int _selectedIndex = 0;

  final List<Widget> _telas = [
    TelaServicos(),
    const TelaAgendamento(),
    const TelaHorarios(),
    TelaPerfilBarb(),
  ];


  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Horários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
