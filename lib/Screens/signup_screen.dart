import 'package:flutter/material.dart';
import 'package:to_do/Functions/user_signin_and%20_signout.dart';
import 'package:to_do/Widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _userNameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordConfirmationController = TextEditingController();

  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5ED),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Logo dark.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _userNameController,
                    prefix: const Icon(Icons.account_circle),
                    hintText: 'Username',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Enter a username';
                      } else if (value.trim().length < 3) {
                        return 'Username must be have at least 3 characters long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    prefix: const Icon(Icons.mail_rounded),
                    hintText: 'Email',
                    validator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)
                          ? null
                          : "Enter valid email";
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    obscureText: hidePassword,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    prefix: const Icon(Icons.vpn_key),
                    hintText: 'Password',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a password';
                      } else if (value.trim().length < 8) {
                        return 'Password must be have at least 8 characters long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordConfirmationController,
                    obscureText: hidePasswordConfirm,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordConfirm = !hidePasswordConfirm;
                        });
                      },
                      icon: Icon(hidePasswordConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    prefix: const Icon(Icons.vpn_key),
                    hintText: 'Confirm password',
                    validator: (value) {
                      if (value == _passwordController.text) {
                        return null;
                      } else {
                        return 'Password does not match';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        await registerUser(
                            _userNameController.text,
                            _emailController.text,
                            _passwordConfirmationController.text,
                            context);

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
