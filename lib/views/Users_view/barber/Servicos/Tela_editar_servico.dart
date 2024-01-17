import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../consts/consts.dart';

class TelaEditarServico extends StatefulWidget {
  final DocumentSnapshot document;

  const TelaEditarServico({Key? key, required this.document}) : super(key: key);

  @override
  _TelaEditarServicoState createState() => _TelaEditarServicoState();
}

class _TelaEditarServicoState extends State<TelaEditarServico> {
  late TextEditingController _nomeController;
  late TextEditingController _valorController;
  late TextEditingController _minutosController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.document['nome']);
    _valorController = TextEditingController(text: widget.document['valor'].toString());
    _minutosController = TextEditingController(text: widget.document['minutos'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Serviço'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Serviço'),
            ),
            TextFormField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _minutosController,
              decoration: InputDecoration(labelText: 'Minutos'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _salvarAlteracoes(context);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarAlteracoes(BuildContext context) {
    String novoNome = _nomeController.text;
    double novoValor = double.parse(_valorController.text);
    int novosMinutos = int.parse(_minutosController.text);

    FirebaseFirestore.instance.collection('servicos').doc(widget.document.id).update({
      'nome': novoNome,
      'valor': novoValor,
      'minutos': novosMinutos,
    });

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _valorController.dispose();
    _minutosController.dispose();
    super.dispose();
  }
}