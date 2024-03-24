import 'package:expenses_mobile_app/src/pages/Estatisticas/despesas_x_lucro_chart_page.dart';
import 'package:expenses_mobile_app/src/pages/Estatisticas/extrato_mensal_chart_page.dart';
import 'package:expenses_mobile_app/src/pages/Estatisticas/saldo_disponivel_chart_page.dart';
import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:flutter/material.dart';

class Estatisticas extends StatefulWidget {
  const Estatisticas({super.key});

  @override
  State<Estatisticas> createState() => _EstatisticasState();
}

class _EstatisticasState extends State<Estatisticas> {
  int buttonSelected = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final double saldoInicial = arguments['saldoInicial'];
    final double saldoDisponivel = arguments['saldoDisponivel'];
    final List<Extrato> extratoLista = arguments['extratoLista'];

    return Scaffold(
        appBar: AppBar(
            title: const Text('Estatísticas'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
            )),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SegmentedButton(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Saldo Disponivel')),
                  ButtonSegment(value: 1, label: Text('Extrato Mensal')),
                  ButtonSegment(value: 2, label: Text('Despesas x Lucros')),
                ],
                selected: {buttonSelected},
                onSelectionChanged: (value) {
                  setState(() {
                    buttonSelected = value.first;
                  });
                  pageController.animateToPage(
                    value.first,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    buttonSelected = value;
                  });
                },
                children: [
                  SaldoDisponivelChart(
                      extratoLista: extratoLista,
                      saldoDisponivel: saldoDisponivel,
                      saldoInicial: saldoInicial),
                  ExtratoMensalChart(
                      extratoLista: extratoLista,
                      saldoDisponivel: saldoDisponivel,
                      saldoInicial: saldoInicial),
                  DespesaXLucroChart(
                      extratoLista: extratoLista,
                      saldoDisponivel: saldoDisponivel,
                      saldoInicial: saldoInicial),
                ],
              ),
            )
          ],
        ));
  }
}
