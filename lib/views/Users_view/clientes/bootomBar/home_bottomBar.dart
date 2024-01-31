import 'package:agendfael/views/Users_view/clientes/viewPrincipal/agendamentos_cliente.dart';
import 'package:agendfael/views/Users_view/clientes/viewPrincipal/historico_cliente.dart';
import 'package:agendfael/views/Users_view/clientes/viewPrincipal/homeView_cliente.dart';
import 'package:agendfael/views/perfil/tela_perfil.dart';
import 'package:flutter/material.dart';

class ButtomBarClientes extends StatefulWidget {
  const ButtomBarClientes({super.key});

  @override
  State<ButtomBarClientes> createState() => _ButtomBarClientesState();
}

class _ButtomBarClientesState extends State<ButtomBarClientes> {

  int _selectedIndex = 0;

  final List<Widget> _telas = [
    const HomeViewCliente(),
    const AgendamentoClientes(),
    const HistoricoCliente(),
    TelaPerfil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Histórico',
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