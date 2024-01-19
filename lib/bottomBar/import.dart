import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uzmbs/bottomBar/qr_scanner.dart';
import 'package:uzmbs/bottomBar/qr_scanner1.dart';
import '../res/getController.dart';

class ImportPage extends StatelessWidget {
  ImportPage({Key? key}) : super(key: key);
  final _getcontroller = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: QRViewExample1(),
      )
    );
  }
}