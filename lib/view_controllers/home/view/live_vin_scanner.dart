import 'package:camera/camera.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:raff/utils/text_recognetion/detector_view.dart';
import 'package:raff/utils/text_recognetion/vin_reader_manager.dart';
import 'package:raff/view_controllers/home/model/camera_manager.dart';

class LiveVinScanner extends StatefulWidget {
  @override
  State<LiveVinScanner> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<LiveVinScanner> {
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;
  CameraController? _cameraController;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      await CameraManager().initalizeController().then((value) {
        _cameraController = value;
      });
      setState(() {});
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  @override
  void dispose() {
    _canProcess = false;
    _textRecognizer.close();
    _cameraController?.dispose();
    CameraManager().stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_cameraController?.value.isInitialized ?? false)
            DetectorView(
              title: 'Text Detector',
              text: _text,
              onImage: _processImage,
              initialCameraLensDirection: _cameraLensDirection,
              onCameraLensDirectionChanged: (value) =>
                  _cameraLensDirection = value,
            ),
        ],
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    _isBusy = true;

    setState(() {
      _text = '';
    });

    final recognizedText = await _textRecognizer.processImage(inputImage);
    List<String> detectedVins = VinReaderManager()
        .detectVins(recognizedText)
        .where((element) => element.isBackup == false)
        .map((e) => e.vin)
        .toList();
    if (detectedVins.isNotEmpty && mounted) {
      CameraManager().stopLiveFeed();
      Navigator.of(context).pop(detectedVins);
      return;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  String convertToEnglish(String input) {
    return removeDiacritics(
        input); // Removes accents, converts characters to base form
  }

  bool isEnglish(String input) {
    final RegExp englishRegex = RegExp(r'^[a-zA-Z0-9\s.,!?"@#%^&*()_+\-=]*$');
    return englishRegex.hasMatch(input);
  }
}
