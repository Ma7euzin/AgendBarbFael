
class Servico {
  final String nome;
  final double valor;
  final int minutos;
  final String barbeiroId;

  Servico({
    required this.nome,
    required this.valor,
    required this.minutos,
    required this.barbeiroId,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'valor': valor,
      'minutos': minutos,
      'barbeiroId': barbeiroId,
    };
  }
}