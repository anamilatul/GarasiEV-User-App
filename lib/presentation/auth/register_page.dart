import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/presentation/auth/login_page.dart';
import '../../bloc/register/register_bloc.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/models/request/register_request_model.dart';
import '../../utils/color_resources.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../custom_widgets/button/custom_button.dart';
import '../custom_widgets/text_field/custom_password_textfield.dart';
import '../custom_widgets/text_field/custom_textfield.dart';
import '../main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState>? _formKey;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool isEmailVerified = false;

  void addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (name.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("all fields are required to be filled in."),
            backgroundColor: Colors.red,
          ),
        );
      } else if (!email.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The email must contain '@'."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password and confirm password not match."),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          final model = RegisterRequestModel(
            name: name,
            email: email,
            password: password,
          );
          context.read<RegisterBloc>().add(RegisterEvent.register(model));
          isEmailVerified = true;
        }
      }
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: Dimensions.topSpace),
            Center(child: Image.asset(Images.logo, height: 100, width: 200)),
            const SizedBox(height: Dimensions.topSpace),
            const Text(
              'Create Account',
              style: poppinsBoldWallet,
            ),
            const SizedBox(
              height: Dimensions.marginSizeSmall,
            ),
            const Text(
              "If you don't have an account? \nPlease create new account with us",
              style: poppinsRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: Dimensions.topSpace,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.marginSizeDefault,
                              right: Dimensions.marginSizeDefault),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                hintText: 'Name',
                                textInputType: TextInputType.name,
                                focusNode: _fNameFocus,
                                nextNode: _lNameFocus,
                                isPhoneNumber: false,
                                capitalization: TextCapitalization.words,
                                controller: _nameController,
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.marginSizeDefault,
                              right: Dimensions.marginSizeDefault,
                              top: Dimensions.marginSizeSmall),
                          child: CustomTextField(
                            hintText: 'Email',
                            focusNode: _emailFocus,
                            nextNode: _phoneFocus,
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.marginSizeDefault,
                              right: Dimensions.marginSizeDefault,
                              top: Dimensions.marginSizeSmall),
                          child: CustomPasswordTextField(
                            hintTxt: 'Password',
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            nextNode: _confirmPasswordFocus,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.marginSizeDefault,
                              right: Dimensions.marginSizeDefault,
                              top: Dimensions.marginSizeSmall),
                          child: CustomPasswordTextField(
                            hintTxt: 'Confirm Password',
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: Dimensions.marginSizeLarge,
                        right: Dimensions.marginSizeLarge,
                        bottom: Dimensions.marginSizeLarge,
                        top: Dimensions.marginSizeLarge),
                    child: BlocListener<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () {},
                            error: (message) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                  ),
                                ),
                            loaded: (data) async {
                              await AuthLocalDataSource().saveAuth(data);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                  (route) => false);
                            });
                      },
                      child: BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => CustomButton(
                                onTap: addUser, buttonText: 'Create Account'),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          },
                          child: Text(
                            'Skip for Now',
                            style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.primaryMaterial),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.marginSizeAuthSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ?",
                        style: poppinsRegular,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          'Sign In',
                          style: poppinsRegular,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
