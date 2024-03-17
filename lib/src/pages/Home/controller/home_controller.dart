import 'package:expenses_mobile_app/src/shared/Services/pref_service.dart';
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
    PrefService.save(
      saldo: saldo,
      despesa: despesas,
      listaDispesa: dispesaLista,
    );
    notifyListeners();
  }

  void deleteDespesa(int index) {
    dispesaLista.removeAt(index);
    _atualizaDespesas();
    notifyListeners();
  }

  void loadDespesas() async {
    var data = await PrefService.read();
    saldo = data['saldo'] ?? 0;
    despesas = data['despesa'] ?? 0;
    var lista = data['listaDespesa'] ?? [];
    dispesaLista = lista.map<Dispesa>((e) => Dispesa.fromJson(e)).toList();
    notifyListeners();
  }
}
