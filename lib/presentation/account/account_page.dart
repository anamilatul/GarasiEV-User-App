import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/profile/profile_bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/auth_local_datasource.dart';
import 'package:flutter_garasi_ev/presentation/auth/login_page.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import '../../bloc/logout/logout_bloc.dart';
import '../../data/models/request/profile_request_model.dart';
import '../../utils/costum_themes.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  GlobalKey<FormState>? _formKey;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  void initState() {
    // context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.primaryMaterial,
        elevation: 0,
        title: Text(
          'Profile',
        ),
        actions: [
          BlocConsumer<LogoutBloc, LogoutState>(
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
                  return IconButton(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            },
          )
        ],
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
                        height: 60,
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
                        padding: const EdgeInsets.only(top: 10),
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
                                title: Text("Phone"),
                                subtitle: LinearProgressIndicator(),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                                color: Colors.grey[300],
                              ),
                              ListTile(
                                title: Text("Bio"),
                                subtitle: LinearProgressIndicator(),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                                color: Colors.grey[300],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorResources.primaryMaterial,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Update Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
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
                                  title: Text("Phone"),
                                  subtitle: Text(profile.phone ?? "-"),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                ListTile(
                                  title: Text("Bio"),
                                  subtitle: Text(profile.bio ?? "-"),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                  color: Colors.grey[300],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: ColorResources.primaryMaterial,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      nameController.text = profile.name;
                                      emailController.text = profile.email;
                                      phoneController.text =
                                          profile.phone ?? '';
                                      bioController.text = profile.bio ?? '';
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.all(18),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Icon(
                                                            Icons.arrow_back,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Update Profile',
                                                          style:
                                                              poppinsRegularLarge,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    TextField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Name',
                                                      ),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          emailController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Email',
                                                      ),
                                                    ),
                                                    TextField(
                                                      controller:
                                                          phoneController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Phone',
                                                      ),
                                                    ),
                                                    TextField(
                                                      controller: bioController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Bio',
                                                      ),
                                                    ),
                                                    SizedBox(height: 16),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .primaryMaterial,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: BlocConsumer<
                                                          ProfileBloc,
                                                          ProfileState>(
                                                        listener:
                                                            (context, state) {
                                                          state.maybeWhen(
                                                              orElse: () {},
                                                              loaded: (data) {
                                                                context
                                                                    .read<
                                                                        ProfileBloc>()
                                                                    .add(const ProfileEvent
                                                                        .getProfile());
                                                              });
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          return state
                                                              .maybeWhen(
                                                            orElse: () {
                                                              return MaterialButton(
                                                                onPressed: () {
                                                                  String name =
                                                                      nameController
                                                                          .text;
                                                                  String email =
                                                                      emailController
                                                                          .text;
                                                                  String phone =
                                                                      phoneController
                                                                          .text;
                                                                  String bio =
                                                                      bioController
                                                                          .text;

                                                                  if (name.isNotEmpty ||
                                                                      email
                                                                          .isNotEmpty ||
                                                                      phone
                                                                          .isNotEmpty ||
                                                                      bio.isNotEmpty) {
                                                                    // Memanggil event update profile dari bloc dengan data baru
                                                                    context
                                                                        .read<
                                                                            ProfileBloc>()
                                                                        .add(ProfileEvent
                                                                            .updateProfile(
                                                                          ProfileRequestModel(
                                                                              name: name,
                                                                              email: email,
                                                                              phone: phone,
                                                                              bio: bio),
                                                                        ));
                                                                    context
                                                                        .read<
                                                                            ProfileBloc>()
                                                                        .add(const ProfileEvent
                                                                            .getProfile());
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Updates',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Update Profile",
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // ListTile(
                                //   title: Text("Created At"),
                                //   subtitle: Text(profile.createdAt.toString()),
                                // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
