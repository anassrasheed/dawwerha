import 'package:sizer/sizer.dart';

class StringHelper {
  static final shared = StringHelper();

  String replaceArabicNumbers({required String arabic}) {
    return arabic
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9')
        .replaceAll('۰',
            '0') // don't remove the duplicate please (asci code is different)
        .replaceAll('۱', '1')
        .replaceAll('۲', '2')
        .replaceAll('۳', '3')
        .replaceAll('۴', '4')
        .replaceAll('۵', '5')
        .replaceAll('۶', '6')
        .replaceAll('۷', '7')
        .replaceAll('۸', '8')
        .replaceAll('۹', '9')
        .replaceAll('*', '')
        .replaceAll('#', '')
        .replaceAll(',', '')
        .replaceAll(';', '')
        .replaceAll('+', '')
        .replaceAll('٫', '.');
  }

  static double fontSize(double dp) {
    return ((dp / 300) * 100.w);
  }
}
