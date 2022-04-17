import 'package:flutter/material.dart';
import 'package:to_do/Functions/user_signin_and%20_signout.dart';
import 'package:to_do/Parameters/common_parameters.dart';
import 'package:to_do/Screens/signup_screen.dart';
import 'package:to_do/Widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool hidePassword = true;
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
              key: loginFormkey,
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
                    controller: _emailController,
                    prefix: const Icon(Icons.mail_rounded),
                    hintText: 'Email',
                    validator: (value) {
                      if (emailError == null) {
                        if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return null;
                        } else {
                          return 'Enter valid email';
                        }
                      } else {
                        return emailError;
                      }
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
                      if (passWordError == null) {
                        if (value!.trim().isEmpty) {
                          return 'Enter password';
                        } else if (value.trim().length < 8) {
                          return 'Enter a valid password (Min. 8 characters)';
                        } else {
                          return null;
                        }
                      } else {
                        return passWordError;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      passWordError = null;
                      emailError = null;

                      if (loginFormkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        await loginUser(_emailController.text,
                            _passwordController.text, context);
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
                        : const Text("Login"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((ctx) => SignUpScreen())));
                          },
                          child: const Text('Sign Up')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
