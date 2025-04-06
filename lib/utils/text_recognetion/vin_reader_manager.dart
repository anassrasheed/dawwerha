import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:raff/utils/text_recognetion/vin_reader_model.dart';

class VinReaderManager {
  VinReaderManager._private();

  static final VinReaderManager _shared = VinReaderManager._private();

  factory VinReaderManager() => _shared;

  List<VinReaderModel> detectVins(RecognizedText recognizedText,
      {bool isLiveScan = true}) {
    List<VinReaderModel> detectedVins = [];
    Set<String> allWords = {};

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        allWords.addAll(line.text.split(RegExp(r'\s+')));
      }
    }

    for (String value in allWords) {
      value = value.replaceAll("I", '1');
      value = value.replaceAll("O", '0');
      value = value.replaceAll("o", '0');
      value = value.replaceAll("Q", '0');

      if (isValidVIN(value)) {
        detectedVins.add(VinReaderModel(vin: value));
      } else if (value.length > 15 && value.length < 19) {
        detectedVins.add(VinReaderModel(vin: value, isBackup: true));
      }
    }

    if (!isLiveScan &&
        detectedVins.where((element) => element.isBackup == false).isEmpty) {
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          String text =
              line.text.replaceAll(RegExp(r'\s+'), ''); 
          text = text.replaceAll("I", '1'); // Replace 'I' with '1'
          text = text.replaceAll("O", '0'); // Replace 'O' with '0'
          text = text.replaceAll("o", '0'); // Replace 'o' with '0'
          text = text.replaceAll("Q", '0'); // Replace 'Q' with '0'
          text = text.replaceAll("-", ''); // Replace 'Q' with '0'

          for (int i = 0; i <= text.length - 17; i++) {
            String segment = text.substring(i, i + 17);

            if (isValidVIN(segment)) {
              detectedVins.add(
                  VinReaderModel(vin: segment));
            }
          }
        }
      }
    }
    if (detectedVins.isNotEmpty) {
      detectedVins = detectedVins.toSet().toList();
    }
    return detectedVins;
  }

  bool isValidVIN(String vin) {
    // G1STRAT10NRENEWAL
    vin = vin.replaceAll("I", '1');
    vin = vin.replaceAll("O", '0');
    vin = vin.replaceAll("o", '0');
    vin = vin.replaceAll("Q", '0');

    if (vin.length != 17) {
      return false;
    }

    const allowedCharacters = 'ABCDEFGHJKLMNPRSTUVWXYZ0123456789';
    for (int i = 0; i < vin.length; i++) {
      if (!allowedCharacters.contains(vin[i])) {
        return false;
      }
    }

    const Map<String, int> charValues = {
      'A': 1,
      'B': 2,
      'C': 3,
      'D': 4,
      'E': 5,
      'F': 6,
      'G': 7,
      'H': 8,
      'J': 1,
      'K': 2,
      'L': 3,
      'M': 4,
      'N': 5,
      'P': 7,
      'R': 9,
      'S': 2,
      'T': 3,
      'U': 4,
      'V': 5,
      'W': 6,
      'X': 7,
      'Y': 8,
      'Z': 9,
      '0': 0,
      '1': 1,
      '2': 2,
      '3': 3,
      '4': 4,
      '5': 5,
      '6': 6,
      '7': 7,
      '8': 8,
      '9': 9
    };

    // الأوزان لكل خانة
    const List<int> weights = [
      8,
      7,
      6,
      5,
      4,
      3,
      2,
      10,
      0,
      9,
      8,
      7,
      6,
      5,
      4,
      3,
      2
    ];

    // حساب المجموع وفقاً للخوارزمية
    int sum = 0;
    for (int i = 0; i < vin.length; i++) {
      String character = vin[i];
      int value = charValues[character] ?? 0;
      int weight = weights[i];
      sum += value * weight;
    }

    // حساب خانة التحقق
    int checkDigit = sum % 11;
    String expectedCheckDigit = checkDigit == 10 ? 'X' : checkDigit.toString();

    // مقارنة خانة التحقق في VIN مع النتيجة المحسوبة

    String lastFourChars = vin.substring(vin.length - 4);

    RegExp regExp = RegExp(r'^[A-Za-z]{4}$');

    bool result =
        vin[8] == expectedCheckDigit && !regExp.hasMatch(lastFourChars);
    if (result) {
      print('success');
    }
    return result;
  }
}
