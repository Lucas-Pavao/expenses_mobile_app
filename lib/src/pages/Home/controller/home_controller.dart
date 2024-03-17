import 'package:expenses_mobile_app/src/shared/model/dispesa_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  double saldo = 0;
  double despesas = 0;
  List<Dispesa> dispesaLista = [];
  TextEditingController saldoController = TextEditingController();

  void addDispesa(Dispesa dispesa) {
    dispesaLista.add(dispesa);
    _atualizaDespesas();
    notifyListeners();
  }

  void addSaldo() {
    saldo = double.parse(saldoController.text);
    _atualizaDespesas();
    notifyListeners();
  }

  _atualizaDespesas() {
    despesas = saldo;
    for (var dispesa in dispesaLista) {
      despesas += dispesa.valor;
    }
    notifyListeners();
  }

  void deleteDespesa(int index) {}
}
