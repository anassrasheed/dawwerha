import 'package:camera/camera.dart';
import 'dart:io';

class CameraManager {
  CameraManager._privateConstructor();

  factory CameraManager() => _instance;
  static final CameraManager _instance = CameraManager._privateConstructor();

  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  CameraDescription? selectedCamera;

  List<CameraDescription> get cameras => _cameras;

  Future<CameraController> initalizeController() async {
    if (_controller == null) {
      if (_cameras.isEmpty) {
        _cameras = await availableCameras();
      }
      int _cameraIndex = 0;

      for (var i = 0; i < _cameras.length; i++) {
        if (_cameras[i].lensDirection == CameraLensDirection.back) {
          _cameraIndex = i;
          break;
        }
      }
      selectedCamera = _cameras[_cameraIndex];
      _controller = CameraController(
        selectedCamera!,
        // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
    }
    if (_controller!.value.isInitialized) return _controller!;
    await _controller?.initialize();
    return _controller!;
  }

  Future stopLiveFeed() async {
    if (_controller != null) {
      await _controller?.stopImageStream();
      await _controller?.dispose();
      _controller = null;
    }
  }
}
