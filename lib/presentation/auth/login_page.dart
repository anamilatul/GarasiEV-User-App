import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/login/login_bloc.dart';
import 'package:flutter_garasi_ev/data/models/request/login_request_model.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../custom_widgets/button/custom_button.dart';
import '../custom_widgets/text_field/custom_password_textfield.dart';
import '../custom_widgets/text_field/custom_textfield.dart';
import '../main_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState>? _formKeyLogin;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  void loginUser() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();

      String email = _emailController!.text.trim();
      String password = _passwordController!.text.trim();

      if (email.isEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email and Password Can't be Empty"),
          backgroundColor: Colors.red,
        ));
      } else if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Can't be Empty"),
          backgroundColor: Colors.red,
        ));
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password Can't be Empty"),
          backgroundColor: Colors.red,
        ));
      } else {
        final model = LoginRequestModel(
          email: email,
          password: password,
        );
        context.read<LoginBloc>().add(LoginEvent.login(model));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: Dimensions.topSpace),
            Center(child: Image.asset(Images.logo, height: 100, width: 200)),
            const SizedBox(height: Dimensions.topSpace),
            const Text(
              'Sign In',
              style: poppinsBoldWallet,
            ),
            const SizedBox(
              height: Dimensions.marginSizeSmall,
            ),
            const Text(
              'Welcome back, \nSign in to continue with existing account',
              style: poppinsRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: Dimensions.topSpace,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.marginSizeLarge),
                child: Form(
                  key: _formKeyLogin,
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: Dimensions.marginSizeSmall,
                        ),
                        child: CustomTextField(
                          hintText: 'Email',
                          focusNode: _emailNode,
                          nextNode: _passwordNode,
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: Dimensions.marginSizeDefault,
                        ),
                        child: CustomPasswordTextField(
                          hintTxt: 'Password',
                          textInputAction: TextInputAction.done,
                          focusNode: _passwordNode,
                          controller: _passwordController,
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(
                      //     right: Dimensions.marginSizeSmall,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Checkbox(
                      //             checkColor: ColorResources.white,
                      //             activeColor: Theme.of(context).primaryColor,
                      //             value: false,
                      //             onChanged: (val) {},
                      //           ),
                      //           const Text('Remember', style: poppinsRegular),
                      //         ],
                      //       ),
                      //       InkWell(
                      //         onTap: () {},
                      //         child: Text('Forgot Password',
                      //             style: poppinsRegular.copyWith(
                      //                 color: ColorResources.lightSkyBlue)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                                orElse: () {},
                                loaded: (data) async {
                                  await AuthLocalDataSource().saveAuth(data);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage()),
                                      (route) => false);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Login Successfully"),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                error: (message) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                    backgroundColor: Colors.red,
                                  ));
                                });
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                                orElse: () {
                                  return CustomButton(
                                      onTap: loginUser, buttonText: 'Sign In');
                                },
                                loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text('Or',
                              style: poppinsRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault))),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        },
                        child: Container(
                          // margin: const EdgeInsets.only(
                          //     left: Dimensions.marginSizeAuth,
                          //     right: Dimensions.marginSizeAuth,
                          //     top: Dimensions.marginSizeAuthSmall),
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Continue as Guest',
                              style: titleHeader.copyWith(
                                  color: ColorResources.primaryMaterial)),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: poppinsRegular,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            child: const Text(
                              'Create Account',
                              style: poppinsRegular,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
