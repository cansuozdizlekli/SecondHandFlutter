// ignore_for_file: file_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/RegisterController.dart';
import 'package:first_app/screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.find<RegisterController>();

  RegisterScreen({Key? key}) : super(key: key);

  void register() {
    try {
      var email = controller.emailController.value.text;
      var password = controller.passwordController.value.text;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar("Welcome!", "Welcome to our second hand app");
        Get.to(() => LoginScreen());
      });
    } catch (error) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  // ignore: non_constant_identifier_names
  void RegisterToLogin() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 30,
                  ),
                  Image(
                    image: AssetImage(
                      "images/shopbag.webp",
                    ),
                    width: 100,
                    height: 100,
                  ),
                  Text("Second Hand",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontSize: 25)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent),
                ),
                onPressed: register,
                child: const Text("Register"),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: RegisterToLogin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Already a member?',
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
