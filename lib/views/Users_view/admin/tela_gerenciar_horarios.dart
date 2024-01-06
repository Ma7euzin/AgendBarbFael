import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaGerenciarHorario extends StatefulWidget {

  TelaGerenciarHorario({super.key});

  @override
  State<TelaGerenciarHorario> createState() => _TelaGerenciarHorarioState();
}

class _TelaGerenciarHorarioState extends State<TelaGerenciarHorario> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _segundaAberturaController;
  late TextEditingController _segundaFechamentoController;

  late TextEditingController _tercaAberturaController;
  late TextEditingController _tercaFechamentoController;

  late TextEditingController _quartaAberturaController;
  late TextEditingController _quartaFechamentoController;

  late TextEditingController _quintaAberturaController;
  late TextEditingController _quintaFechamentoController;

  late TextEditingController _sextaAberturaController;
  late TextEditingController _sextaFechamentoController;

  late TextEditingController _sabadoAberturaController;
  late TextEditingController _sabadoFechamentoController;

  @override
  void initState() {
    super.initState();
    _segundaAberturaController = TextEditingController(text: '08:00');
    _segundaFechamentoController = TextEditingController(text: '18:00');
    _tercaAberturaController = TextEditingController(text: '08:00');
    _tercaFechamentoController = TextEditingController(text: '18:00');
    _quartaAberturaController = TextEditingController(text: '08:00');
    _quartaFechamentoController = TextEditingController(text: '18:00');
    _quintaAberturaController = TextEditingController(text: '08:00');
    _quintaFechamentoController = TextEditingController(text: '18:00');
    _sextaAberturaController = TextEditingController(text: '08:00');
    _sextaFechamentoController = TextEditingController(text: '18:00');
    _sabadoAberturaController = TextEditingController(text: '08:00');
    _sabadoFechamentoController = TextEditingController(text: '18:00');
    // Inicialize os controllers para os demais dias, se necessário
  }
  

  void _salvarHorarios( Map<String, Map<String, String>> horarios) {
    _firestore.collection('barbearia').doc('id_da_barbearia').set({
      'horarioFuncionamento': horarios,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Horários atualizados com sucesso!')),
      );
    }).catchError((error) {
      print('Erro ao salvar os horários: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar os horários. Tente novamente.')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    /*Map<String, Map<String, String>> horarios = {
      'segunda': {'abertura': '08:00', 'fechamento': '18:00'},
      'terca': {'abertura': '08:00', 'fechamento': '18:00'},
      'Quarta': {'abertura': '08:00', 'fechamento': '18:00'},
      'Quinta': {'abertura': '08:00', 'fechamento': '18:00'},
      'Sexta': {'abertura': '08:00', 'fechamento': '18:00'},
      'Sabado': {'abertura': '08:00', 'fechamento': '18:00'},
      // Adicione os horários para os demais dias
    };*/

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Horário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Horários de Funcionamento:',
                style: TextStyle(fontSize: 18),
              ),
              _buildDiaHorarioTextField(
                'Segunda-feira', _segundaAberturaController, _segundaFechamentoController
              ),
              _buildDiaHorarioTextField(
                'terca-feira', _tercaAberturaController, _tercaFechamentoController
              ),
              _buildDiaHorarioTextField(
                'quarta-feira', _quartaAberturaController, _quartaFechamentoController
              ),
              _buildDiaHorarioTextField(
                'quinta-feira', _quintaAberturaController, _quintaFechamentoController
              ),
              _buildDiaHorarioTextField(
                'Sexta-feira', _sextaAberturaController, _sextaFechamentoController
              ),
              _buildDiaHorarioTextField(
                'Sabado', _sabadoAberturaController, _sabadoFechamentoController
              ),
              // Adicione campos para os demais dias
        
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Map<String, Map<String, String>> horarios = {
                    'segunda': {
                      'abertura': _segundaAberturaController.text,
                      'fechamento': _segundaFechamentoController.text,
                    },
                    'terca': {
                      'abertura': _tercaAberturaController.text,
                      'fechamento': _tercaFechamentoController.text,
                    },
                    'quarta': {
                      'abertura': _quartaAberturaController.text,
                      'fechamento': _quartaFechamentoController.text,
                    },
                    'quinta': {
                      'abertura': _quintaAberturaController.text,
                      'fechamento': _quintaFechamentoController.text,
                    },
                    'sexta': {
                      'abertura': _sextaAberturaController.text,
                      'fechamento': _sextaFechamentoController.text,
                    },
                    'sabado': {
                      'abertura': _sabadoAberturaController.text,
                      'fechamento': _sabadoFechamentoController.text,
                    },
                    // Preencha os dados para os demais dias
                  };
                  _salvarHorarios(horarios);
                },
                child:  const Center(child: Text('Salvar Horários')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiaHorarioTextField(String dia, TextEditingController aberturaController, TextEditingController fechamentoController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          dia,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: aberturaController,
                decoration: InputDecoration(labelText: 'Abertura'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: fechamentoController,
                decoration: InputDecoration(labelText: 'Fechamento'),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  void dispose() {
    _segundaAberturaController.dispose();
    _segundaFechamentoController.dispose();
    _tercaAberturaController.dispose();
    _tercaFechamentoController.dispose();
    _quartaAberturaController.dispose();
    _quartaFechamentoController.dispose();
    _quintaAberturaController.dispose();
    _quintaFechamentoController.dispose();
    _sextaAberturaController.dispose();
    _sextaFechamentoController.dispose();
    _sabadoAberturaController.dispose();
    _sabadoFechamentoController.dispose();
    // Descarte os controllers dos demais dias, se necessário
    super.dispose();
  }





}
