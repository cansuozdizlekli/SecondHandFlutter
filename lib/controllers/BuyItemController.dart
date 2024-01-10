import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:get/state_manager.dart";
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/models/advertisement.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class BuyItemController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  Future<void> buyAd(Advertisement ad) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference ads = firestore.collection('sells');

    // Call the user's CollectionReference to add a new user
    await ads.add({
      'id': ad.id,
      'title': ad.title,
      'description': ad.description,
      'image': ad.photo,
      'tag': ad.tags,
      'price': ad.price,
      'seller': ad.author,
      'buyer': FirebaseAuth.instance.currentUser?.email
    }).then((value) async {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('ads');
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Get data from docs and convert map to List
      final document =
          querySnapshot.docs.where((element) => element["id"] == ad.id);

      FirebaseFirestore.instance
          .doc("ads/${document.first.id}")
          .delete()
          .then((value) {
        mainController.fetchData();
        Get.back();
        Get.snackbar("Congratulations", "You bought an item");
      });
    }).catchError((error) => print("Failed to delete advertisement: $error"));
  }
}
