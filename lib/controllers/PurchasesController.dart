import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/models/advertisement.dart';
import 'package:get/get.dart';

class PurchasesController extends GetxController {
  final myPurchases = [].obs;

  @override
  void onInit() async {
    super.onInit();

    fetchPurchases();
  }

  void fetchPurchases() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('sells');
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .where((element) =>
            element["buyer"].toString() ==
            FirebaseAuth.instance.currentUser?.email)
        .map(
          (doc) => Advertisement(
              id: doc["id"],
              title: doc["title"],
              description: doc["description"],
              photo: doc["image"],
              tags: doc["tag"],
              price: doc["price"],
              author: doc["seller"]),
        )
        .toList();

    myPurchases.value = allData;
  }
}
