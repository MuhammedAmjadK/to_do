import 'package:flutter/material.dart';
import 'package:to_do/Functions/user_signin_and%20_signout.dart';
import 'package:to_do/Parameters/common_parameters.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF7F5ED),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    userName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    userEmail!,
                    style: const TextStyle(
                      color: Color(0xFFF7F5ED),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              signOutUser(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
