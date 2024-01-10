import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';

import 'package:first_app/controllers/PurchasesController.dart';
import 'package:first_app/widgets/AdItem.dart';

class Purchases extends StatelessWidget {
  Purchases({Key? key}) : super(key: key);

  final PurchasesController purchasesController =
      Get.find<PurchasesController>();

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Obx(
          () => Column(
            children: [
              GridView.builder(
                primary: true,
                shrinkWrap: true,
                itemCount: purchasesController.myPurchases.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (BuildContext context, int index) => GridTile(
                  child: AdItem(
                      advertisement: purchasesController.myPurchases[index],
                      isMyAdd: false,
                      isBought: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
