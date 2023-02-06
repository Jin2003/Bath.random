import 'dart:developer';
import 'dart:io';

import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/group_select_page.dart';
import 'package:bath_random/pages/regi_account_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReadPage extends StatefulWidget {
  const QrReadPage({super.key});

  @override
  State<QrReadPage> createState() => _QrReadPageState();
}

class _QrReadPageState extends State<QrReadPage> {
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // ホットリロードすると呼ばれる処理
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // QRカメラの初期化時
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    // スキャンしたデータを取得できるように、listenする
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  // カメラのパーミッションがセットされると呼ばれる処理
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  // QRコードを読み取る枠の部分のウィジェット
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: _buildQrView(context),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (result != null)
                    // debug
                    // Text(
                    // 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result?.code}'
                    // )
                    CustomButton(
                      title: "登録画面へ",
                      width: 120,
                      height: 45,
                      nextPage: RegiAccountPage(groupID: result!.code!),
                    )
                  else
                    const Text('QR'),
                  const SizedBox(
                    width: 120,
                    height: 20,
                  ),
                  const CustomButton(
                    title: 'もどる',
                    width: 120,
                    height: 45,
                    nextPage: GroupSelectPage(),
                  ),
                  const SizedBox(
                    width: 120,
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
