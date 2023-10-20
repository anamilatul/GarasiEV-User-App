import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/profile/profile_bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/auth_local_datasource.dart';
import 'package:flutter_garasi_ev/presentation/auth/login_page.dart';
import 'package:flutter_garasi_ev/presentation/main_page.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';

import '../../bloc/logout/logout_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.primaryMaterial,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Profile',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                          color: ColorResources.primaryMaterial,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              "assets/images/profile.png",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () {
                          context
                              .read<ProfileBloc>()
                              .add(const ProfileEvent.getProfile());
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 245, 245),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromARGB(255, 215, 215, 215),
                              ),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("Nama"),
                                  subtitle: Text("-"),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  title: Text("Email"),
                                  subtitle: Text("-"),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  title: Text("Created At"),
                                  subtitle: Text("-"),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 245, 245),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 215, 215, 215),
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Nama"),
                                subtitle: LinearProgressIndicator(),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                                color: Colors.grey[300],
                              ),
                              ListTile(
                                title: Text("Email"),
                                subtitle: LinearProgressIndicator(),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                                color: Colors.grey[300],
                              ),
                              ListTile(
                                title: Text("Created At"),
                                subtitle: LinearProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                        loaded: (profile) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 245, 245),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color.fromARGB(255, 215, 215, 215),
                              ),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("Nama"),
                                  subtitle: Text(profile.name),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  title: Text("Email"),
                                  subtitle: Text(profile.email),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  title: Text("Created At"),
                                  subtitle: Text(profile.createdAt.toString()),
                                ),
                              ],
                            ),
                          );
                        },
                        error: (message) {
                          return Center(child: Text("Error: $message"));
                        },
                      );
                    },
                  ),
                ],
              ),
              BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeWhen(
                      orElse: () {},
                      loaded: (message) {
                        AuthLocalDataSource().removeAuth();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors
                              .red, // Ganti warna latar sesuai kebutuhan (misalnya merah)
                          borderRadius: BorderRadius.circular(
                              25), // Tambahkan radius border
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            context
                                .read<LogoutBloc>()
                                .add(const LogoutEvent.logout());
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors
                                  .white, // Ganti warna teks sesuai kebutuhan (misalnya putih)
                            ),
                          ),
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
