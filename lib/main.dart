import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/category/category_bloc.dart';
import 'package:flutter_garasi_ev/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_garasi_ev/bloc/order/order_bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/auth_local_datasource.dart';
import 'package:flutter_garasi_ev/presentation/main_page.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/logout/logout_bloc.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'presentation/auth/login_page.dart';
import 'utils/light_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: light,
        // home: MainPage(),
        home: FutureBuilder<bool>(
          future: AuthLocalDataSource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
