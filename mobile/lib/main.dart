import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterproject2/pages/Homepage/home_page.dart';
import 'package:flutterproject2/pages/Create_User/user_bloc.dart';
// import 'package:flutterproject2/pages/DashboardPage/dashboard_page.dart';
import 'package:flutterproject2/pages/SplashScreen.dart';
import 'package:flutterproject2/pages/TransactionPage/transaction_page.dart';
import 'package:flutterproject2/pages/product_page/product.dart';
import 'Auth/login_page.dart';
import 'package:flutterproject2/pages/SalesPage/sales_page.dart';
// import 'package:flutterproject2/pages/Setting/settings.dart';
import 'package:flutterproject2/bloc/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ProductBloc()),
      ],
      child: MaterialApp(
        initialRoute: '/splashscreen',
        routes: {
          '/splashscreen': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/products': (context) => const ProductPage(),
          // '/createuserpage': (context) => const CreateUserPage(),
          '/salespage': (context) => const SalesPage(),
          '/homepage': (context) => const HomePage(),
          '/transactionpage': (context) => const TransactionPage(),
          // '/dashboardpage': (context) => const DashboardPage(),
          // '/settings': (context) => const SettingsPage(),
        },
      ),
    );
  }
}
