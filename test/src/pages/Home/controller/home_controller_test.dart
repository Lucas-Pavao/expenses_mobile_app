import 'package:expenses_mobile_app/src/pages/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';

void main() {
  group('HomeController', () {
    setUpAll(() async {
      WidgetsFlutterBinding.ensureInitialized();
    });

    test('Adding expense updates total expenses correctly', () {
      final controller = HomeController();
      final initialExpenses = controller.saldoDisponivel;

      // Add an expense
      final expense = Extrato(
        valor: 50.0,
        nome: 'Teste',
        icon: Icons.ac_unit,
        iconColor: Colors.blue,
        data: '2021-10-10',
        diaSemana: "Segunda-feira",
      );
      controller.addExtrato(expense);

      // Verify that the expenses have been updated correctly
      expect(
          controller.saldoDisponivel, equals(initialExpenses + expense.valor));
    });

    test('Deleting expense updates total expenses correctly', () {
      final controller = HomeController();
      final initialExpenses = controller.saldoDisponivel;
      final expense = Extrato(
        valor: 50.0,
        nome: 'Teste',
        icon: Icons.ac_unit,
        iconColor: Colors.blue,
        data: '2021-10-10',
        diaSemana: "Segunda-feira",
      );
      controller.addExtrato(expense);

      // Delete the added expense
      controller.deleteExtrato(0);

      // Verify that the expenses have been updated correctly
      expect(controller.saldoDisponivel, equals(initialExpenses));
    });

    test('Adding balance updates total balance and expenses correctly', () {
      final controller = HomeController();
      final initialExpenses = controller.saldoDisponivel;

      // Add a balance
      controller.saldoController.text = '100.0';
      controller.addSaldo();

      // Verify that the balance and expenses have been updated correctly
      expect(controller.saldoInicial, equals(100.0));
      expect(controller.saldoDisponivel, equals(initialExpenses + 100.0));
    });
  });
}
