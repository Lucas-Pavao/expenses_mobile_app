import 'package:flutter/material.dart';

class SaldoDisponivelChart extends StatefulWidget {
  const SaldoDisponivelChart({super.key});

  @override
  State<SaldoDisponivelChart> createState() => _SaldoDisponivelChartState();
}

class _SaldoDisponivelChartState extends State<SaldoDisponivelChart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Saldo Disponivel'),
    );
  }
}
