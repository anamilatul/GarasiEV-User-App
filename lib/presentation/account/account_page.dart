import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/auth_local_datasource.dart';
import 'package:flutter_garasi_ev/presentation/auth/login_page.dart';

import '../../bloc/logout/logout_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: (message) {
                  AuthLocalDataSource().removeAuth();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Logout Successfully"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                error: ((message) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ));
                }));
          },
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    child: const Text("Logout"),
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ));
          },
        ),
      ),
    );
  }
}
