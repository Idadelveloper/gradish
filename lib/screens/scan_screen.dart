import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:googleapis/vision/v1.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  final String _base64String = '';

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

  // Uint8List _imageBytes = Uint8List(0);


  //
  // Future<String> getFileFromAsset(String assetFileName,
  //     {String? temporaryFileName}) async {
  //   final byteData = await rootBundle.load('assets/$assetFileName');
  //
  //   final buffer = byteData.buffer;
  //
  //   final fileName = temporaryFileName ?? assetFileName;
  //
  //   final filePath = await getTempFile(fileName);
  //
  //   await File(filePath).delete();
  //
  //   await File(filePath).writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return filePath;
  // }
  //
  // Future<String> getTempFile([String? fileName]) async {
  //   final tempDir = await getTemporaryDirectory();
  //
  //   return '${tempDir.path}${Platform.pathSeparator}${fileName ?? UniqueKey().toString()}';
  // }
  //
  // Future imageToBase64(String imagePath) async {
  //   // String imagePath = "assets/gfglogo.png";
  //   File imageFile = File(imagePath);
  //
  //   Uint8List bytes = await imageFile.readAsBytes();
  //
  //   String base64String = base64.encode(bytes);
  //   setState(() {
  //     base64String = base64String;
  //   });
  //
  // }

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
                  ),
                floatingActionButton: FloatingActionButton(
                  // Provide an onPressed callback.
                  onPressed: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    try {
                      

                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      final image = await _cameraController!.takePicture();
                      final file = File(image.path);
                      // final inputImage = InputImage.fromFile(file);

                      // var path = getTempFile(image.path);
                      // print("Path $path");
                      // var encoded = await imageToBase64(path as String);
                      // print("Encoded string: $encoded, Path: $path");
                      if (!mounted) return;



                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                  child: const Icon(Icons.camera_alt),
                ),
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



