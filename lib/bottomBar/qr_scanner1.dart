import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uzmbs/res/colors.dart';

import '../res/getController.dart';

class QRViewExample1 extends StatelessWidget {
  QRViewExample1({super.key});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final Rx<Barcode?> result = Rx<Barcode?>(null);
  final RxBool cameraReady = RxBool(false);
  final lampOn = false.obs;
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Center(
          child: (orientation == Orientation.portrait)
              ? _buildPortraitView(context)
              : _buildLandscapeView(context),
        );
      },
    );
  }

  Widget _buildPortraitView(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: w,
            height: h,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Obx(() => (result.value != null)
                  ? Text('${result.value!.code}')
                  : const Text('')),
            ),
          ),
          Positioned(
            top: h * 0.01,
            right: w * 0.01,
            child: IconButton(
              onPressed: () {
                controller!.toggleFlash();
                lampOn.toggle();
              },
              icon: Obx(() => (lampOn.value)
                  ? HeroIcon(
                HeroIcons.lightBulb,
                size: MediaQuery.of(context).size.width * 0.07,
                color: AppColors.secondaryColor,
              )
                  : HeroIcon(
                HeroIcons.lightBulb,
                size: MediaQuery.of(context).size.width * 0.07,
                color: AppColors.primaryColor,
              )),
            ),
          ),
          Positioned(
            top: h * 0.01,
            child: Container(
              width: w * 0.5,
              height: h * 0.05,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Obx(() => _getController.index.value == 0
                    ? Text(
                  'Scan QR Import',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                  ),
                )
                    : _getController.index.value == 1
                    ? Text(
                  'Scan QR Export',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                  ),
                ) : Text(
                  'Scan QR Check',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.035,
                  ),
                )),
              ),
            )
          ),
          // Center 4 corners line
          Center(
            child: CustomPaint(
              size: Size(w * 0.8, h * 0.3),
              painter: CenterLinePainter(),
            ),
          ),
        ],
      )

    );
  }

  Widget _buildLandscapeView(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Obx(() => (result.value != null)
                  ? Text('${result.value!.code}')
                  : const Text('')),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            child: IconButton(
              onPressed: () {
                controller!.toggleFlash();
                lampOn.toggle();
              },
              icon: Obx(() => (lampOn.value)
                  ? HeroIcon(
                HeroIcons.lightBulb,
                size: MediaQuery.of(context).size.width * 0.07,
                color: AppColors.secondaryColor,
              ) : HeroIcon(
                HeroIcons.lightBulb,
                size: MediaQuery.of(context).size.width * 0.07,
                color: AppColors.primaryColor,
              )),
            ),
          ),
          // Center 4 corners line
          Center(
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width * 0.4,
                  MediaQuery.of(context).size.height * 0.5),
              painter: CenterLinePainter(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result.value = scanData;
      //your code
      Get.back();
    });
  }
}

class CenterLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(size.width / 8, 0),
      Offset(size.width / 4, 0),
      paint,
    );

    // Draw vertical line top
    canvas.drawLine(
      Offset(size.width / 8, 0),
      Offset(size.width / 8, size.height / 8),
      paint,
    );

    // Draw vertical line bottom
    canvas.drawLine(
      Offset(size.width / 8, size.height / 8 * 7),
      Offset(size.width / 8, size.height),
      paint,
    );

    // Draw horizontal line bottom
    canvas.drawLine(
      Offset(size.width / 8, size.height),
      Offset(size.width / 4, size.height),
      paint,
    );

    //Draw horizontal line bottom right
    canvas.drawLine(
      Offset(size.width / 4 * 3, size.height),
      Offset(size.width / 4 * 3 + size.width / 8, size.height),
      paint,
    );

    //Draw horizontal line top right
    canvas.drawLine(
      Offset(size.width / 4 * 3, 0),
      Offset(size.width / 4 * 3 + size.width / 8, 0),
      paint,
    );

    //Draw vertical line top right
    canvas.drawLine(
      Offset(size.width / 4 * 3 + size.width / 8, 0),
      Offset(size.width / 4 * 3 + size.width / 8, size.height / 8),
      paint,
    );

    //Draw vertical line bottom right
    canvas.drawLine(
      Offset(size.width / 4 * 3 + size.width / 8, size.height / 8 * 7),
      Offset(size.width / 4 * 3 + size.width / 8, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

