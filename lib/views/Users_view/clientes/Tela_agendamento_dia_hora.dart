// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AgendDiaHora extends StatefulWidget {
  final DocumentSnapshot barbeiroSelecionado;
  final List<String> servicosSelecionados;
  final int duracaoTotal;
  final double valorTotal;

  const AgendDiaHora({
    super.key,
    required this.servicosSelecionados,
    required this.duracaoTotal,
    required this.valorTotal,
    required this.barbeiroSelecionado,
  });

  @override
  State<AgendDiaHora> createState() => _AgendDiaHoraState();
}

class _AgendDiaHoraState extends State<AgendDiaHora> {
  List<String> horariosDoDia = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference horariosCollection =
      FirebaseFirestore.instance.collection('horario');

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? _horarioSelecionado;
  String? _dataFormatada;
  bool _horarioPendente = false;

  final Map<DateTime, List<String>> _horariosPorDia = {};
  final TextEditingController _horarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusDay = DateTime.now();

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
        automaticallyImplyLeading: false,
        title: const Center(child: Text('')),
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
                        _horarioSelecionado = null;
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
                    'Escolha seu Horario de Atendimento',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: horariosDoDia.isEmpty
                    ? SemHorariosWidget()
                    : Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                4, // Ajuste o número de colunas conforme necessário
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: horariosDoDia.length,
                          itemBuilder: (context, index) {
                            String horario = horariosDoDia[index];

                            return FutureBuilder<bool>(
                              future: _obterStatusPendente(
                                DateFormat('yyyy-MM-dd').format(_currentDay),
                                horario,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  bool horarioPendente = snapshot.data ?? false;
                                  

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          horarioPendente
                                              ? _horarioSelecionado = null
                                              : _horarioSelecionado = horario;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: horarioPendente
                                              ? Colors.red
                                              : (_horarioSelecionado == horario
                                                  ? Colors.blueAccent
                                                  : null),
                                        ),
                                        child: Center(
                                          child: Text(
                                            horario,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Pode mostrar um indicador de carregamento enquanto espera
                                  return const CircularProgressIndicator();
                                }
                              },
                            );
                          },
                        ),
                      ),
              ),
              if (_horarioSelecionado != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _horarioPendente
                        ? null
                        : () {
                            // Lógica de agendamento
                            // Implemente o que deseja fazer quando o botão é pressionado
                            // Por exemplo, abrir uma nova tela de confirmação ou realizar o agendamento diretamente
                            print("Agendamento para $_horarioSelecionado");
                          },
                    child: Text('Agendar para $_horarioSelecionado'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  //Verificando se o status de pendente esta true
  Future<void> _verificarStatusPendente() async {
    if (_horarioSelecionado != null) {
      try {
        CollectionReference horarioCollection =
            FirebaseFirestore.instance.collection('horario');

        DocumentReference userDocument =
            horarioCollection.doc(widget.barbeiroSelecionado.id);

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await userDocument.get() as DocumentSnapshot<Map<String, dynamic>>;

        if (snapshot.exists) {
          Map<String, dynamic>? userData =
              (snapshot.data() as Map<String, dynamic>?) ?? {};

          if (userData.containsKey(_dataFormatada)) {
            Map<String, dynamic> horariosDoDiaMap =
                userData[_dataFormatada] as Map<String, dynamic>;

            if (horariosDoDiaMap.containsKey(_horarioSelecionado)) {
              bool statusPendente =
                  horariosDoDiaMap[_horarioSelecionado]['pendente'] == true;

              setState(() {
                _horarioPendente = statusPendente;
              });
            }
          }
        }
      } catch (error) {
        print("Erro ao verificar status pendente: $error");
      }
    }
  }

  //Obter estatus do horario Selecionado
  Future<bool> _obterStatusPendente(String dataFormatada, String horario) async {
  try {
    CollectionReference horarioCollection =
        FirebaseFirestore.instance.collection('horario');

    DocumentReference userDocument =
        horarioCollection.doc(widget.barbeiroSelecionado.id);

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userDocument.get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      Map<String, dynamic>? userData =
          (snapshot.data() as Map<String, dynamic>?) ?? {};

      if (userData.containsKey(dataFormatada)) {
        Map<String, dynamic> horariosDoDiaMap =
            userData[dataFormatada] as Map<String, dynamic>;

        if (horariosDoDiaMap.containsKey(horario)) {
          return horariosDoDiaMap[horario]['pendente'] == true;
        }
      }
    }
  } catch (error) {
    print("Erro ao obter status pendente: $error");
  }

  return false;
}

  Future<List<String>> obterHorariosDoDia(DateTime data) async {
  try {
    CollectionReference horarioCollection =
        FirebaseFirestore.instance.collection('horario');

    DocumentReference userDocument =
        horarioCollection.doc(widget.barbeiroSelecionado.id);

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userDocument.get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() ?? {};
      String dataFormatada = DateFormat('yyyy-MM-dd').format(data);

      if (userData.containsKey(dataFormatada)) {
        Map<String, dynamic> horariosDoDiaMap =
            userData[dataFormatada] as Map<String, dynamic>;

        List<String> horariosDoDia =
            horariosDoDiaMap.keys.map((hora) => hora.toString()).toList()
              ..sort((a, b) {
                DateTime horaA = DateFormat.Hm().parse(a);
                DateTime horaB = DateFormat.Hm().parse(b);
                return horaA.compareTo(horaB);
              });

        if (widget.duracaoTotal > 0 && _horarioSelecionado != null) {
          DateTime horaEscolhida =
              DateFormat.Hm().parse(_horarioSelecionado!);

          // Filtrar os horários que são mais cedo que a hora escolhida
          horariosDoDia = horariosDoDia.where((hora) {
            DateTime horaAtual = DateFormat.Hm().parse(hora);
            bool isAnterior = horaAtual.isBefore(horaEscolhida);

            if (isAnterior) {
              String horarioPosterior = horariosDoDia.firstWhere(
                  (h) => DateFormat.Hm().parse(h).isAfter(horaEscolhida));

              bool pendentePosterior =
                  horariosDoDiaMap[horarioPosterior]['pendente'] ?? false;
              DateTime horaPosterior =
                  DateFormat.Hm().parse(horarioPosterior);

              Duration intervalo = horaPosterior.difference(horaAtual);

              // Remover horário se o posterior tiver pendente true e
              // o intervalo for menor ou igual a duracaoTotal
              return !(pendentePosterior &&
                  intervalo.inMinutes < widget.duracaoTotal);
            }

            return true;
          }).toList();
        }

        return horariosDoDia;
      }
    }
  } catch (e) {
    print("Erro ao obter horários do dia: $e");
  }

  return [];
}
}

class SemHorariosWidget extends StatelessWidget {
  const SemHorariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Não há Horarios para este dia.',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
