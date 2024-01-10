import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/MyAdsController.dart';
import 'package:first_app/widgets/AdItem.dart';

class ActiveAds extends StatelessWidget {
  ActiveAds({Key? key}) : super(key: key);
  final mainController = Get.find<MyAdsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount: mainController.myAds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (BuildContext context, int index) => GridTile(
                    child: AdItem(
                      advertisement: mainController.myAds[index],
                      isMyAdd: true,
                      isBought: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
