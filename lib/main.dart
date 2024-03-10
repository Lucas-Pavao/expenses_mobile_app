import 'package:expenses_mobile_app/app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppWidget());
  // runApp(MultiProvider(providers: [
  //   ChangeNotifierProvider(
  //     create: (context) => SelectLoginSignupController(),
  //   ),
  //   ChangeNotifierProvider(create: (context) => ResidenceUserMapController()),
  //   ChangeNotifierProvider(
  //       create: (context) => ResidenceUserCreateFormController()),
  //   ChangeNotifierProvider(create: (context) => HomeUserController()),
  //   ChangeNotifierProvider(
  //       create: (context) => ResidenceUserMapDetailController()),
  // ], child: const AppWidget()));
}
