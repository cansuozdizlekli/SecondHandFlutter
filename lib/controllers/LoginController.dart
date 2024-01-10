import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  // we can put all of the logıc that can change durıng the runnıng of the app
  /// ınsıde of a controller
  ///
  /// In thıs case, the changıng values are emaıl and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
