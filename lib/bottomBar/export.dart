import 'package:flutter/material.dart';
import 'package:uzmbs/bottomBar/qr_scanner1.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRViewExample1(),
    );
  }
}