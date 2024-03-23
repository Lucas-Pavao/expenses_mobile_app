import 'package:expenses_mobile_app/app_widget.dart';
import 'package:expenses_mobile_app/src/pages/Estatisticas/controller/estatisticas_controller.dart';
import 'package:expenses_mobile_app/src/pages/Home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HomeController(),
    ),
    ChangeNotifierProvider(
      create: (context) => EstatisticasController(),
    )
  ], child: const AppWidget()));
}
