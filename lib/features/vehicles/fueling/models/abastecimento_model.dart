class Abastecimento {
  final int id;
  final int hodometro;
  final double totalLitros;
  final double precoCombustivel;
  final DateTime dataAbastecimento;
  final int hodometroDiferenca;
  final int diasEntreAbastecimentos;
  final double litrosPorDia;
  final double kmDia;
  final double totalGastoAbastecimento;
  final double consumoMedio;

  Abastecimento({
    required this.id,
    required this.hodometro,
    required this.totalLitros,
    required this.precoCombustivel,
    required this.dataAbastecimento,
    required this.hodometroDiferenca,
    required this.diasEntreAbastecimentos,
    required this.litrosPorDia,
    required this.kmDia,
    required this.totalGastoAbastecimento,
    required this.consumoMedio,
  });

  factory Abastecimento.fromJson(Map<String, dynamic> json) {
    return Abastecimento(
      id: json['id'],
      hodometro: json['hodometro'],
      totalLitros: json['total_litros']?.toDouble() ?? 0.0,
      precoCombustivel: json['preco_combustivel']?.toDouble() ?? 0.0,
      dataAbastecimento: DateTime.parse(json['data_abastecimento']),
      hodometroDiferenca: json['hodometro_diferenca'],
      diasEntreAbastecimentos: json['dias_entre_abastecimentos'],
      litrosPorDia: json['litros_por_dia']?.toDouble() ?? 0.0,
      kmDia: json['km_dia']?.toDouble() ?? 0.0,
      totalGastoAbastecimento: json['total_gasto_abastecimento']?.toDouble() ?? 0.0,
      consumoMedio: json['consumo_medio']?.toDouble() ?? 0.0,
    );
  }
}