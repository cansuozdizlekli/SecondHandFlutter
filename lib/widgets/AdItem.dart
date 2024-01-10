import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/BuyItemController.dart';
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/controllers/MyAdsController.dart';
import 'package:first_app/models/advertisement.dart';

class AdItem extends StatelessWidget {
  final Advertisement advertisement;
  final bool isMyAdd;
  final bool isBought;
  final MainController mainController = Get.find<MainController>();
  final MyAdsController myAdsController = Get.find<MyAdsController>();
  final BuyItemController buyItemController = Get.find<BuyItemController>();

  AdItem(
      {Key? key,
      required this.advertisement,
      required this.isMyAdd,
      required this.isBought})
      : super(key: key);

  void deleteItem(String id) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('ads');
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final document = querySnapshot.docs.where((element) => element["id"] == id);

    FirebaseFirestore.instance
        .doc("ads/${document.first.id}")
        .delete()
        .then((value) {
      Get.snackbar("Congratulations", "You deleted your product successfully");
      mainController.fetchData();
      myAdsController.fetchMyAds();
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = OutlinedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Buy"),
      onPressed: () {
        buyItemController.buyAd(advertisement);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Buy item"),
      content: const Text("Would you like to continue buying the item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            advertisement.photo,
            height: 150,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(advertisement.title),
          Text(advertisement.description),
          Text(advertisement.tags),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${advertisement.price.toString()}\$",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          isBought
              ? Row(
                  children: [
                    Text(
                      "Seller: ${advertisement.author}",
                      style: const TextStyle(fontSize: 9),
                    )
                  ],
                )
              : Container(),
          isBought
              ? Container()
              : isMyAdd
                  ? OutlinedButton(
                      onPressed: () {
                        deleteItem(advertisement.id);
                      },
                      child: const Text(
                        "Delete Item",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent[700]),
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      child: const Text("Buy the item"),
                    ),
        ],
      ),
    );
  }
}
