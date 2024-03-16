import 'package:expenses_mobile_app/src/shared/model/dispesa_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  double saldo = 0;
  double despesas = 100;
  List<Dispesa> dispesaLista = [];

  void addDispesa(Dispesa dispesa) {
    dispesaLista.add(dispesa);
    notifyListeners();
  }

  // bool virifcaDespesas() {
  //   if (despesas < 0) {
  //     print('Despesas negativas');
  //     notifyListeners();
  //     return true;
  //   } else {
  //     print('Despesas positivas');
  //     notifyListeners();
  //     return false;
  //   }
  // }
}
