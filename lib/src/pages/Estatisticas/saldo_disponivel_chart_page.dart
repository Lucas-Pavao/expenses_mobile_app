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
  bool isShowingMainData = false;

  LineChartData _loadSaldoDisonivelData(List<Extrato> extratoLista) {
    final List<FlSpot> spots = [];
    double saldo = widget.saldoInicial;
    spots.add(FlSpot(0, saldo));
    for (var i = 0; i < extratoLista.length; i++) {
      saldo += extratoLista[i].valor;
      spots.add(FlSpot(i.toDouble(), saldo));
    }

    return LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: isShowingMainData ? spots : [],
          isCurved: true,
          show: true,
          curveSmoothness: 0.3,
          preventCurveOverShooting: true,
          // shadow: Shadow(
          //   color: Theme.of(context).colorScheme.primary,
          //   blurRadius: 10,
          //   offset: const Offset(0, 3),
          // ),
          color: Theme.of(context).colorScheme.primary,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        isShowingMainData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Colors.black12
                            : Colors.white12,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LineChart(
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 800),
                    _loadSaldoDisonivelData(widget.extratoLista),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Saldo Inicial',
                      style: Theme.of(context).textTheme.bodySmall),
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
                  Text('Saldo Disponivel',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(
                    'R\$ ${widget.saldoDisponivel < 0 ? "-" : "+"} ${widget.saldoDisponivel.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.saldoDisponivel < 0
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
