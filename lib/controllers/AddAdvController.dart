import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:get/state_manager.dart";
import 'package:uuid/uuid.dart';

class AddAdvController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final selectedPhoto = "".obs;

  void setSelectedPhoto(String photo) {
    selectedPhoto.value = photo;
  }

  Future<void> addAdvertisement() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference ads = firestore.collection('ads');
    var id = const Uuid().v1();
    // Call the user's CollectionReference to add a new user
    return ads
        .add({
          'id': id,
          'title': titleController.text,
          'description': descriptionController.text,
          'image': selectedPhoto.value,
          'tag': tagController.text,
          'price': int.parse(priceController.text),
          'user': FirebaseAuth.instance.currentUser?.email.toString()
        })
        .then((value) => print("Ad has been added"))
        .catchError((error) => print("Failed to add advertisement: $error"));
  }
}
