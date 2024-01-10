import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/AddAdvController.dart';
import 'package:first_app/controllers/LoginController.dart';
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/controllers/MyAdsController.dart';
import 'package:first_app/screens/Main.dart';
import 'package:first_app/screens/Register.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  LoginScreen({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();

  void login() {
    try {
      var email = loginController.emailController.value.text;
      var password = loginController.passwordController.value.text;

      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        var currentUser = FirebaseAuth.instance.currentUser?.email;
        // We can show snackbar wıdget usıng GetX
        Get.snackbar("Welcome", "Welcome ${currentUser}");
        Get.put(MainController());
        Get.put(AddAdvController());
        Get.put(MyAdsController());
        // when logın ıs successful, we can go to the MaınScreen
        Get.to(() => MainScreen());

// always start from the fırst tab ın maın screen
        mainController.index.value = 0;
      });
    } catch (error) {}
  }

  void goToRegister() {
    // routıng ıs controlled by GetX
    Get.to(() => RegisterScreen());
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
                  Text(
                    "Second Hand",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: loginController.emailController,
                decoration: const InputDecoration(labelText: "E-Mail"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: loginController.passwordController,
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
                onPressed: login,
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(width: 90),
                  const Text("Not a member?"),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: goToRegister,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
