import 'package:flutter/material.dart';

// import '../business_managers/model/responses/lockups/get_lockups_response.dart';

class AppConstants {
  static const categoryType = 2;
  static const serviceType = 1;
  static const arabicFontName = 'Roboto';
  static const englishFontName = 'Roboto';
  static const appAndroidVersion = 1.0;
  static const appIOSVersion = 1.0;
  static const int navigationDuration = 300;
  static const int backDuration = 800;
  static Color baseColor = Colors.grey[100]!;
  static Color highlightColor = Colors.grey[300]!;
  //
  // static List<LookupModel> completionRate = [
  //   LookupModel(id: 1, name: 'أقل من 50%'),
  //   LookupModel(id: 2, name: 'من 50% إلى 75%'),
  //   LookupModel(id: 3, name: 'من 75% إلى 100%'),
  //   LookupModel(id: 4, name: '100%'),
  // ];
  // static List<LookupModel> remainingTime = [
  //   LookupModel(id: 1, name: '5 أيام%'),
  //   LookupModel(id: 2, name: '10 أيام'),
  //   LookupModel(id: 3, name: '20 يوم'),
  //   LookupModel(id: 4, name: 'منتهي'),
  // ];

  static Map<String, String> extensions = {
    'PDF': "assets/pdf.png",
    'XLS': 'assets/excel.png',
    'XLSX': 'assets/excel.png',
    'WORD': 'assets/word.png',
    'DOCX': 'assets/word.png',
    'DOC': 'assets/word.png',
    'PPTX': 'assets/pptx.png',
    'PPT': 'assets/pptx.png',
  };
}
