// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../consts/consts.dart';

class TelaHorarios extends StatefulWidget {
  const TelaHorarios({super.key});

  @override
  State<TelaHorarios> createState() => _TelaHorariosState();
}

class _TelaHorariosState extends State<TelaHorarios> {
  List<String> horariosDoDia = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference horariosCollection =
      FirebaseFirestore.instance.collection('horarios');

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  Map<DateTime, List<String>> _horariosPorDia = {};
  TextEditingController _horarioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Chame a função para obter os horários do dia no momento da inicialização
    obterHorariosDoDia(DateTime.now()).then((horarios) {
      setState(() {
        horariosDoDia = horarios;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de horarios'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 650,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  locale: 'pt_BR',
                  focusedDay: _focusDay,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2024, 12, 31),
                  calendarFormat: _format,
                  currentDay: _currentDay,
                  rowHeight: 30,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _format = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_currentDay, day);
                  },
                  onDaySelected: ((selectedDay, focusedDay) {
                    setState(() {
                      if (_horariosPorDia[selectedDay] == null) {
                        _horariosPorDia[selectedDay] = [];
                      }
                      _currentDay = selectedDay;
                      _focusDay = focusedDay;
                      _dateSelected = true;
                      if (selectedDay.weekday == 6 ||
                          selectedDay.weekday == 7) {
                        _isWeekend = true;
                        _timeSelected = false;
                        _currentIndex = null;
                      } else {
                        _isWeekend = false;
                      }
                    });
                    obterHorariosDoDia(selectedDay).then((horarios) {
                      setState(() {
                        horariosDoDia = horarios;
                      });
                    });
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                  child: Text(
                    'Cadastre Seus Horarios de atendimento desse dia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _horarioController,
                  decoration: const InputDecoration(
                    labelText: 'Horário (HH:mm)',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  adicionarHorario(_focusDay, _horarioController.text);
                  //_adicionarHorario();
                },
                child: const Text('Adicionar Horário'),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: horariosDoDia.map((horario) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          horario,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        // Adicione outras propriedades ListTile conforme necessário
                        onTap: () {
                          mostrarDialogoEditarExcluir(
                              context, horario, _focusDay);
                          //mostrarDialogoEditar(context, horario);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Adicionar horario
  Future<void> adicionarHorario(DateTime data, String horario) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String dataFormatada = DateFormat('yyyy-MM-dd').format(data);

        CollectionReference horarioCollection =
            FirebaseFirestore.instance.collection('horario');
        DocumentReference userDocument = horarioCollection.doc(user.uid);

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await userDocument.get() as DocumentSnapshot<Map<String, dynamic>>;

        if (snapshot.exists) {
          Map<String, dynamic> userData = snapshot.data() ?? {};

          Map<String, dynamic> horariosDoDiaMap = userData[dataFormatada] ?? {};

          // Verifica se o horário já está ocupado
          if (!horariosDoDiaMap.containsKey(horario)) {
            // Adiciona o horário
            horariosDoDiaMap[horario] = {
              'pendente': false,
              'agendado': false,
            };

            // Atualiza o documento no Firestore
            await userDocument.update({
              dataFormatada: horariosDoDiaMap,
            });
          } else {
            print("Horário já Existe.");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Horario Já existe')),
            );
            // Você pode lidar com isso de acordo com sua lógica de aplicativo
          }
          _horarioController.clear();
        }
      }
      await atualizarListaHorarios(data);
    } catch (e) {
      print("Erro ao adicionar horário: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('campo està Vázio')),
      );
    }
  }

  // Função para obter horários do dia
  Future<List<String>> obterHorariosDoDia(DateTime data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String dataFormatada = DateFormat('yyyy-MM-dd').format(data);

        CollectionReference horarioCollection =
            FirebaseFirestore.instance.collection('horario');
        DocumentReference userDocument = horarioCollection.doc(user.uid);

        DocumentSnapshot<Object?> snapshot = await userDocument.get();

        if (snapshot.exists) {
          Map<String, dynamic>? userData =
              snapshot.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey(dataFormatada)) {
            Map<String, dynamic> horariosDoDiaMap =
                userData[dataFormatada] ?? {};

            // Obter as chaves (horários) e ordená-las
            List<String> horariosDoDia = horariosDoDiaMap.keys
                .map((hora) =>
                    hora.toString()) // Converter para String se necessário
                .toList()
              ..sort((a, b) {
                // Comparação personalizada para ordenar de forma crescente
                DateTime horaA = DateFormat.Hm().parse(a);
                DateTime horaB = DateFormat.Hm().parse(b);
                return horaA.compareTo(horaB);
              });

            return horariosDoDia;
          }
        }
      }
    } catch (e) {
      print("Erro ao obter horários do dia: $e");
    }

    return [];
  }

  Future<void> mostrarDialogoEditarExcluir(
      BuildContext context, String horaAntiga, DateTime data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar ou Excluir Hora'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    // Fechar o dialogo
                    Navigator.of(context).pop();

                    // Lógica para editar a hora
                    String? novaHora =
                        await mostrarDialogoEditar(context, horaAntiga);
                    if (novaHora != null) {
                      await editarHorario(horaAntiga, novaHora, data);
                      // Atualizar a interface do usuário após a edição
                      setState(() {
                        // Chame os métodos necessários para atualizar o estado da sua tela
                        obterHorariosDoDia(data);
                      });
                    }
                  },
                  child: const Text('Editar'),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                GestureDetector(
                  onTap: () async {
                    // Fechar o dialogo
                    Navigator.of(context).pop();

                    // Lógica para excluir a hora
                    await excluirHorario(horaAntiga, data);
                    // Atualizar a interface do usuário após a exclusão
                    setState(() {
                      // Chame os métodos necessários para atualizar o estado da sua tela
                    });
                  },
                  child: const Text('Excluir'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> mostrarDialogoEditar(
      BuildContext context, String horaAntiga) async {
    TextEditingController novaHoraController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Hora'),
          content: TextFormField(
            controller: novaHoraController,
            decoration: InputDecoration(
              labelText: 'Nova Hora',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancelar a edição
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context, novaHoraController.text); // Confirmar a edição
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Edição de hora
  Future<void> editarHorario(
      String horaAntiga, String novaHora, DateTime data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String dataFormatada = DateFormat('yyyy-MM-dd').format(data);

        CollectionReference horarioCollection =
            FirebaseFirestore.instance.collection('horario');
        DocumentReference userDocument = horarioCollection.doc(user.uid);

        DocumentSnapshot<Object?> snapshot = await userDocument.get();

        if (snapshot.exists) {
          Map<String, dynamic>? userData =
              snapshot.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey(dataFormatada)) {
            // Excluir a hora antiga
            userData[dataFormatada].remove(horaAntiga);

            // Adicionar a nova hora
            userData[dataFormatada][novaHora] = true;

            // Atualizar no Firestore
            await userDocument.set(userData);
          }
        }
      }
      await atualizarListaHorarios(data);
    } catch (e) {
      print("Erro ao editar horário: $e");
    }
  }

  Future<void> atualizarListaHorarios(DateTime data) async {
    // Atualizar a lista de horários
    List<String> novosHorarios = await obterHorariosDoDia(data);

    // Atualizar o estado da tela
    setState(() {
      horariosDoDia = novosHorarios;
    });
  }

//Remover hora
  Future<void> excluirHorario(String horaAntiga, DateTime data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String dataFormatada = DateFormat('yyyy-MM-dd').format(data);

        CollectionReference horarioCollection =
            FirebaseFirestore.instance.collection('horario');
        DocumentReference userDocument = horarioCollection.doc(user.uid);

        DocumentSnapshot<Object?> snapshot = await userDocument.get();

        if (snapshot.exists) {
          Map<String, dynamic>? userData =
              snapshot.data() as Map<String, dynamic>?;

          if (userData != null && userData.containsKey(dataFormatada)) {
            // Excluir a hora antiga
            userData[dataFormatada].remove(horaAntiga);

            // Atualizar no Firestore
            await userDocument.set(userData);
          }
        }
      }
      await atualizarListaHorarios(data);
    } catch (e) {
      print("Erro ao excluir horário: $e");
    }
  }
}
