import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pigeon_typechannel/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Camera? _camera;
  Widget _previewWidget = Container();

  @override
  void initState() {
    super.initState();
    _getCameraPermission();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _getCameraPermission() async {
    while (!await Permission.camera.request().isGranted) {}
    while (!await Permission.storage.request().isGranted) {}
    while (!await Permission.microphone.request().isGranted) {}
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    _camera = Camera();

    _camera!.setDisplayOrientation(90);

    _camera!.startPreview();
    final int textureId = await _camera!.attachPreviewTexture();

    setState(() {
      _previewWidget = Texture(textureId: textureId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _camera?.releasePreviewTexture();
    _camera?.release();
  }

  Widget _buildPictureButton() {
    return InkResponse(
      onTap: () {
        //_takePicture();
        // _recordAVideo();
      },
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2)),
        child: const Icon(
          Icons.camera,
          color: Colors.grey,
          size: 60,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: _previewWidget,
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            padding: const EdgeInsets.only(
              bottom: 30,
              left: 10,
              right: 10,
              top: 15,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Transform.rotate(
                    angle: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildPictureButton(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
