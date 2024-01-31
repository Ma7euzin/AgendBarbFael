class Agendamento {
  final String id;
  final String barbeiroId;
  final String nomeBarbeiro;
  final String servicosSelecionados;
  final String dataAgendamento;
  final String horarioAgendamento;
  final bool confirmado;
  final bool finalizado;

  Agendamento({
    required this.id,
    required this.barbeiroId,
    required this.nomeBarbeiro,
    required this.servicosSelecionados,
    required this.dataAgendamento,
    required this.horarioAgendamento,
    required this.confirmado,
    required this.finalizado,
  });
}