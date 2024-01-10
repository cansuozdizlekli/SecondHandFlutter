import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/models/advertisement.dart';
import 'package:first_app/widgets/AdItem.dart';

class Ads extends StatelessWidget {
  final MainController mainController = Get.find<MainController>();

  Ads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Obx(
          () => GridView.builder(
            primary: true,
            shrinkWrap: true,
            itemCount: mainController.advertisements.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (BuildContext context, int index) => GridTile(
              child: AdItem(
                advertisement: mainController.advertisements[index],
                isMyAdd: mainController.advertisements
                        .cast<Advertisement>()[index]
                        .author ==
                    FirebaseAuth.instance.currentUser?.email,
                isBought: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
