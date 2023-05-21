import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isPermissionGranted = false;

  late final Future<void> _future;

  @override
  void initState() {
    super.initState();

    _future = _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffffc604),
              centerTitle: true,
              title: IconButton(
                onPressed: null,
                icon: Image.asset('images/logo/logo-black.png'),
                iconSize: 10,
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            body: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Text(
                  _isPermissionGranted
                  ? "Camera Permission Granted"
                  : "Yo",
                  textAlign: TextAlign.center,
                ),
              ),
            )
        );
      }
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: const Color(0xffffc604),
    //       centerTitle: true,
    //       title: IconButton(
    //         onPressed: null,
    //         icon: Image.asset('images/logo/logo-black.png'),
    //         iconSize: 10,
    //       ),
    //       leading: IconButton(
    //         icon: const Icon(Icons.menu),
    //         onPressed: () {},
    //       ),
    //       actions: [
    //         IconButton(
    //           icon: const Icon(Icons.settings),
    //           onPressed: () {},
    //         ),
    //       ],
    //     ),
    //     body: const Column(
    //       children: [
    //
    //       ],
    //     )
    // );
  }
}



