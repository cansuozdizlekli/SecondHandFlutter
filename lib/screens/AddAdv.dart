import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:first_app/controllers/AddAdvController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/MainController.dart';

class AddAdv extends StatelessWidget {
  final AddAdvController addAdvController = Get.find<AddAdvController>();
  final MainController mainController = Get.find<MainController>();

  AddAdv({Key? key}) : super(key: key);

  void getFromGallery() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print("dosya adı" + pickedFile.path);
        final storageRef = FirebaseStorage.instance.ref();
        var file = File(pickedFile.path);

        //Upload to Firebase
        var snapshot = await storageRef
            .child('images/${addAdvController.titleController.text}')
            .putFile(file);

        // get upload url of the ımage
        var downloadUrl = await snapshot.ref.getDownloadURL();
        addAdvController.setSelectedPhoto(downloadUrl);
        print("download url" + downloadUrl);
      }
    } catch (error) {
      print("error catch ici" + error.toString());
    }
  }

  void createAd() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      addAdvController.addAdvertisement().then((value) {
        Get.back();
        Get.snackbar(
            "Congratulations", "You published your product successfully");
        mainController.fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 700,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add Product",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: addAdvController.titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: addAdvController.descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: addAdvController.tagController,
              decoration: const InputDecoration(labelText: "Tag"),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ], // Only numbers
              controller: addAdvController.priceController,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getFromGallery();
              },
              child: Obx(
                () => Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: addAdvController.selectedPhoto.value != ""
                      ? FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                            addAdvController.selectedPhoto.value,
                          ),
                        )
                      : const Center(
                          child: Text("Choose Photo"),
                        ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.greenAccent[700]),
              onPressed: () {
                createAd();
              },
              child: const Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
