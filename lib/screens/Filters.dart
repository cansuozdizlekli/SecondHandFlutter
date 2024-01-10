import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:first_app/controllers/MainController.dart';

class Filters extends StatelessWidget {
  final mainController = Get.find<MainController>();

  Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Filters",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: mainController.minPriceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Min Price"),
            ),
            TextField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ], // Only numbers
              controller: mainController.maxPriceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Max Price"),
            ),
            TextField(
              controller: mainController.tagController,
              decoration: const InputDecoration(labelText: "Tag"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                mainController.applyFilters();
              },
              style: ElevatedButton.styleFrom(primary: Colors.greenAccent[700]),
              child: const Text(
                "Apply Filters",
              ),
            ),
            OutlinedButton(
              onPressed: () {
                mainController.clearFilters();
              },
              child: const Text("Clear Filters",
                  style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
