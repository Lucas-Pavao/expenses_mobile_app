import 'dart:convert';
import 'package:expenses_mobile_app/src/shared/model/dispesa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const String _key = 'key';

  static save(
      {double? saldo, double? despesa, List<Dispesa>? listaDispesa}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _key,
      jsonEncode({
        'saldo': saldo,
        'despesa': despesa,
        'listaDespesa': listaDispesa,
      }),
    );
  }

  static Future<Map<String, dynamic>> read() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(_key);
    if (data != null) {
      return jsonDecode(data);
    }
    return {};
  }
}
