import 'package:expenses_mobile_app/src/shared/Services/pref_service.dart';
import 'package:expenses_mobile_app/src/shared/model/extrato_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  double saldoInicial = 0;
  double saldoDisponivel = 0;
  List<Extrato> extratoLista = [];
  TextEditingController saldoController = TextEditingController();

  void addExtrato(Extrato saldoDisponivel) {
    extratoLista.add(saldoDisponivel);
    _atualizaExtratos();
    notifyListeners();
  }

  void addSaldo() {
    saldoInicial = double.parse(saldoController.text);
    _atualizaExtratos();
    notifyListeners();
  }

  _atualizaExtratos() {
    saldoDisponivel = saldoInicial;
    for (var e in extratoLista) {
      saldoDisponivel += e.valor;
    }
    PrefService.save(
      saldoInicial: saldoInicial,
      saldoDisponivel: saldoDisponivel,
      listaExtrato: extratoLista,
    );
    notifyListeners();
  }

  void deleteExtrato(int index) {
    extratoLista.removeAt(index);
    _atualizaExtratos();
    notifyListeners();
  }

  void loadExtratos() async {
    var data = await PrefService.read();
    saldoInicial = data['saldoInicial'] ?? 0;
    saldoDisponivel = data['Extrato'] ?? 0;
    var lista = data['listaExtrato'] ?? [];
    extratoLista = lista.map<Extrato>((e) => Extrato.fromJson(e)).toList();
    notifyListeners();
  }

  void finalizarMes() {
    saldoInicial = 0;
    saldoDisponivel = 0;
    extratoLista = [];
    _atualizaExtratos();
    notifyListeners();
  }
}
