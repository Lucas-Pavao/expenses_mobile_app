import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SaldoDisponivelChart extends StatefulWidget {
  const SaldoDisponivelChart(
      {super.key,
      required this.saldoInicial,
      required this.saldoDisponivel,
      required this.extratoLista});
  final double saldoInicial;
  final double saldoDisponivel;
  final List<Extrato> extratoLista;

  @override
  State<SaldoDisponivelChart> createState() => _SaldoDisponivelChartState();
}

class _SaldoDisponivelChartState extends State<SaldoDisponivelChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            Column(
              children: [
                Text('Saldo Disponivel',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(
                  'R\$ ${widget.saldoDisponivel.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 1,
              child: LineChart(
                LineChartData(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
