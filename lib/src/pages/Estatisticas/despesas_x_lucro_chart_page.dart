import 'package:expenses_mobile_app/src/pages/Estatisticas/widgets/chart_list_row.dart';
import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DespesaXLucroChart extends StatefulWidget {
  const DespesaXLucroChart(
      {super.key,
      required this.saldoInicial,
      required this.saldoDisponivel,
      required this.extratoLista});

  final double saldoInicial;
  final double saldoDisponivel;
  final List<Extrato> extratoLista;

  @override
  State<DespesaXLucroChart> createState() => _DespesaXLucroChartState();
}

class _DespesaXLucroChartState extends State<DespesaXLucroChart> {
  List<Extrato> despesas = [];
  List<Extrato> lucros = [];
  bool isShowingMainData = false;
  double saldoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Move a chamada para a função _loadDespesaXLucroData para dentro de initState
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        isShowingMainData = true;
        saldoOpacity = 1.0;
      });
    });
  }

  List<PieChartSectionData> _loadDespesaXLucroData(List<Extrato> extratoLista) {
    final List<PieChartSectionData> sections = [];
    double despesa = 0;
    double lucro = 0;

    for (var extrato in extratoLista) {
      if (extrato.valor < 0) {
        despesa += extrato.valor;
      } else {
        lucro += extrato.valor;
      }
    }

    despesas = extratoLista.where((element) => element.valor < 0).toList();
    lucros = extratoLista.where((element) => element.valor > 0).toList();

    sections.add(
      PieChartSectionData(
        color: Colors.red,
        value: despesa.abs(),
        title: '',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    sections.add(
      PieChartSectionData(
        color: Colors.green,
        value: lucro,
        title: '',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    // Adicionando uma seção para o saldo disponível
    sections.add(
      PieChartSectionData(
        color: Theme.of(context).colorScheme.primary,
        value: widget.saldoDisponivel,
        title: '',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    return isShowingMainData ? sections : [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    swapAnimationCurve: Curves.linear,
                    swapAnimationDuration: const Duration(milliseconds: 300),
                    PieChartData(
                      sectionsSpace: isShowingMainData ? 5 : 0,
                      centerSpaceRadius: isShowingMainData ? 110 : 0,
                      sections: _loadDespesaXLucroData(widget.extratoLista),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: saldoOpacity,
                  child: Column(
                    children: [
                      Text('Saldo Disponivel',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        'R\$ ${widget.saldoDisponivel.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Despesas',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'R\$ -${widget.extratoLista.where((element) => element.valor < 0).map((e) => e.valor).reduce((value, element) => value + element).abs().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ListView.builder(
                        itemCount: despesas.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChartListRow(extrato: despesas[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Lucros',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'R\$ +${widget.extratoLista.where((element) => element.valor > 0).map((e) => e.valor).reduce((value, element) => value + element).abs().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ListView.builder(
                        itemCount: lucros.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChartListRow(extrato: lucros[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
