import 'package:flutter/material.dart';
import 'package:fmobile/pages/splashscreen.dart';
import 'package:fmobile/pages/login/login.dart';
import 'package:fmobile/pages/home/home.dart';
import 'package:fmobile/pages/sales/sales.dart';
import 'package:fmobile/pages/transactions/transaction.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(),
        '/homepage': (context) => const HomePage(),
        '/salespage': (context) => const SalesPage(),
        '/transactionpage': (context) => const TransactionPage(),
      },
    );
  }
}
