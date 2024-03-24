import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExtratoMensalChart extends StatefulWidget {
  const ExtratoMensalChart(
      {super.key,
      required this.saldoInicial,
      required this.saldoDisponivel,
      required this.extratoLista});

  final double saldoInicial;
  final double saldoDisponivel;
  final List<Extrato> extratoLista;

  @override
  State<ExtratoMensalChart> createState() => _ExtratoMensalChartState();
}

class _ExtratoMensalChartState extends State<ExtratoMensalChart> {
  List<String> diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  bool isShowingMainData = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        isShowingMainData = true;
      });
    });
  }

  BarChartData _loadBarChartData(List<Extrato> extratoLista) {
    // Mapeia os dias da semana para índices de 0 a 6 (Seg a Dom)
    Map<String, int> diaSemanaMap = {
      'Sunday': 0,
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6
    };

    // Lista para armazenar os valores de entrada e saída para cada dia da semana
    List<double> valoresEntrada = List.filled(7, 0.0);
    List<double> valoresSaida = List.filled(7, 0.0);

    // Itera sobre o extrato para calcular os valores de entrada e saída
    for (Extrato extrato in extratoLista) {
      int indexDiaSemana = diaSemanaMap[extrato.diaSemana]!;
      if (extrato.valor > 0) {
        valoresEntrada[indexDiaSemana] += extrato.valor;
      } else {
        valoresSaida[indexDiaSemana] -=
            extrato.valor; // Considerando valor negativo como saída
      }
    }

    // Lista para armazenar os grupos de barras
    List<BarChartGroupData> barGroups = [];

    // Itera sobre os valores de entrada e saída para criar os grupos de barras
    for (int i = 0; i < 7; i++) {
      double valorEntrada = valoresEntrada[i];
      double valorSaida = valoresSaida[i];

      BarChartGroupData barGroup = BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: valorEntrada,
            color: Colors.green,
            width: 7,
          ),
          BarChartRodData(
            toY: valorSaida,
            color: Colors.red,
            width: 7,
          ),
        ],
      );

      barGroups.add(barGroup);
    }

    return BarChartData(
      maxY: (valoresEntrada + valoresSaida).reduce((a, b) => a > b ? a : b),
      barGroups: isShowingMainData ? barGroups : [],
      borderData: FlBorderData(
        show: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, i) {
                return Text(
                  diasSemana[value.toInt()],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                  ),
                );
              },
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BarChart(
                    _loadBarChartData(widget.extratoLista),
                    swapAnimationCurve: Curves.linear,
                    swapAnimationDuration: const Duration(milliseconds: 800),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Saldo Inicial',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'R\$ ${widget.saldoInicial.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Saldo Disponível',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'R\$ ${widget.saldoDisponivel.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
