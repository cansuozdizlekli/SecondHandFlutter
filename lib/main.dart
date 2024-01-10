import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_app/controllers/AddAdvController.dart';
import 'package:first_app/controllers/BuyItemController.dart';
import 'package:first_app/controllers/LoginController.dart';
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/controllers/MyAdsController.dart';
import 'package:first_app/controllers/PurchasesController.dart';
import 'package:first_app/controllers/RegisterController.dart';
import 'package:first_app/screens/Login.dart';
import 'package:first_app/screens/Main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(MainController(), permanent: true);
  Get.put(RegisterController(), permanent: true);
  Get.put(LoginController(), permanent: true);
  Get.put(MyAdsController(), permanent: true);
  Get.put(AddAdvController(), permanent: true);
  Get.put(BuyItemController(), permanent: true);
  Get.put(PurchasesController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return GetMaterialApp(
      home: Scaffold(body: currentUser != null ? MainScreen() : LoginScreen()),
    );
  }
}
