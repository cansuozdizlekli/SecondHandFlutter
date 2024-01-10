import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/advertisement.dart';
import 'package:get/get.dart';

class MyAdsController extends GetxController {
  final index = 0.obs;
  final myAds = [].obs;

  updateIndex(int index) {
    this.index.value = index;
  }

  @override
  void onInit() async {
    super.onInit();

    fetchMyAds();
  }

  void fetchMyAds() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('ads');
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .where((element) =>
            element["user"].toString() ==
            FirebaseAuth.instance.currentUser?.email)
        .map(
          (doc) => Advertisement(
              id: doc["id"],
              title: doc["title"],
              description: doc["description"],
              photo: doc["image"],
              tags: doc["tag"],
              price: doc["price"],
              author: doc["user"]),
        )
        .toList();

    myAds.value = allData;
  }
}
