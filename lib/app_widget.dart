import 'package:expenses_mobile_app/src/pages/Estatisticas/estatisticas_page.dart';
import 'package:expenses_mobile_app/src/pages/Home/home_page.dart';
import 'package:expenses_mobile_app/src/shared/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      darkTheme: darktheme,
      title: 'Green Track',
      routes: {
        '/home': (context) => const Home(),
        '/estatisticas': (context) => const Estatisticas(),
      },
      home: const Home(),
    );
  }
}
