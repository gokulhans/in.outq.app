import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq/screens/shared/exit_pop/exit_pop_up.dart';

class UserForgotPsdPage extends StatelessWidget {
  const UserForgotPsdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "User Forgot Psd",
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => const Exithome());
              },
              child: const Text("Welcome"))
        ],
      )),
    );
  }
}
