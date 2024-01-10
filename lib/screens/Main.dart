import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/MainController.dart';
import 'package:first_app/controllers/MyAdsController.dart';
import 'package:first_app/controllers/PurchasesController.dart';
import 'package:first_app/screens/AddAdv.dart';
import 'package:first_app/screens/Filters.dart';
import 'package:first_app/screens/Login.dart';
import 'package:first_app/screens/ActiveAds.dart';
import 'package:first_app/screens/Purchases.dart';
import 'package:first_app/widgets/Ads.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final MainController mainController = Get.find<MainController>();
  final MyAdsController myAdsController = Get.find<MyAdsController>();
  final PurchasesController purchasesController =
      Get.find<PurchasesController>();

  void onPressLogout() {
    FirebaseAuth.instance.signOut();
  }

// we store the tab screens ınsıde thıs varıable
// and render the screens based on ındex value ın maınController
  static List<Widget> screens = <Widget>[
    Ads(),
    ActiveAds(),
    Purchases(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Second Hand App"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              // delete all of the routıng stack
              Get.offAll(LoginScreen());
            },
            child: Row(
              children: const [
                Icon(Icons.logout),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // open the bottom menu from GetX
              Get.bottomSheet(Filters());
            },
            child: Row(
              children: const [
                Icon(Icons.format_list_bulleted_sharp),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: screens[mainController.index.value],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Get.bottomSheet(AddAdv());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell),
              label: 'Active Ads',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag_outlined,
              ),
              label: 'My Purchases',
            )
          ],
          currentIndex: mainController.index.value,
          selectedItemColor: Colors.greenAccent[700],
          onTap: (i) {
            mainController.updateIndex(i);
            mainController.fetchData();
            myAdsController.fetchMyAds();
            purchasesController.fetchPurchases();
          },
        ),
      ),
    );
  }
}
