import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras){
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false
    );

    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(
                      child: CameraPreview(_cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                }
              ),
              Scaffold(
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
                  backgroundColor: _isPermissionGranted ? Colors.transparent : null,
                  body: _isPermissionGranted ?
                      Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: const Center(
                              child: ElevatedButton(
                                onPressed: null,
                                child: Text("Scan Script"),
                              ),
                            ),
                          )
                        ],
                      ) : Center(
                    child: Container(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: const Text(
                          "Camera Permission Denied",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              )
          ],
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



