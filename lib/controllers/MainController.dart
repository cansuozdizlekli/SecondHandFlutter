import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/advertisement.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static const INT_MAX = 9223372036854775807;

  // In Getx, we can mark varıables as "CAN BE CHANGED" wıth usıng .obs
  final index = 0.obs;
  final advertisements = [].obs;
  final myAds = [].obs;

  // fılters variables
  final minPrice = 0.obs;
  final maxPrice = 9223372036854775807.obs; // last possible integer
  final tag = "".obs;

// fılters ınputs
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final tagController = TextEditingController();

  updateIndex(int index) {
    this.index.value = index;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    index.value = 0;
  }

// every controller has a lıfecycle
// ıf controller starts to run, thıs method runs automatıcally
  @override
  void onInit() async {
    super.onInit();

    fetchData();
    fetchMyAds();
  }

  void fetchData() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('ads');
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs
        .where((element) => element["price"] > minPrice.value)
        .where((element) => element["price"] < maxPrice.value)
        .where((element) => element["tag"].toString().contains(tag))
        .map(
          (doc) => Advertisement(
            id: doc["id"],
            title: doc["title"],
            description: doc["description"],
            photo: doc["image"],
            tags: doc["tag"],
            price: doc["price"],
            author: doc["user"],
          ),
        )
        .toList();

    advertisements.value = allData;
  }

  void setMaxPriceFilter(int value) {
    maxPrice.value = value;
  }

  void setMinPriceFilter(int value) {
    minPrice.value = value;
  }

  void setTagFilter(String value) {
    tag.value = value;
  }

  void clearFilters() {
    setMaxPriceFilter(INT_MAX);
    setMinPriceFilter(0);
    setTagFilter("");

    minPriceController.text = "";
    maxPriceController.text = "";
    tagController.text = "";
    fetchData();

    Get.back();
  }

  void applyFilters() {
    if (minPriceController.text != "") {
      setMinPriceFilter(int.parse(minPriceController.text));
    }
    if (maxPriceController.text != "") {
      setMaxPriceFilter(int.parse(maxPriceController.text));
    }
    if (tagController.text != "") {
      setTagFilter(tagController.text);
    }

    fetchData();
    Get.back();
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
            author: doc["user"],
          ),
        )
        .toList();

    myAds.value = allData;
  }
}
