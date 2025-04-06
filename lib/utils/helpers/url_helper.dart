// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static final UrlHelper shared = UrlHelper();

  String encodeUrl(String url) {
    if (url.contains('%')) return url;
    String _url = Uri.encodeFull(url);
    _url = urlEncode(text: _url);
    return _url;
  }

  String urlEncode({required String text}) {
    String output = text;

    var detectHash = text.contains('#');
    var detectAnd = text.contains('&');
    var detectSlash = text.contains('/');

    if (detectHash == true) {
      output = output.replaceAll('#', '%23');
    }

    if (detectAnd == true) {
      output = output.replaceAll('#', '%26');
    }

    if (detectSlash == true) {
      output = output.replaceAll('#', '%2F');
    }

    return output;
  }

  Future<void> openUrl({
    required String? url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  }) async {
    if (url == null) return;

    String _url = encodeUrl(url);
    if (!isPdfLink(url: _url)) {
      _url = getURl(_url);
      await launchUrl(
        Uri.parse(_url),
        mode: launchMode,
      );
    } else {
      String _pdfUrl = 'https://docs.google.com/viewer?url=$_url';
      await launchUrl(
        Uri.parse(_pdfUrl),
        mode: launchMode,
      );
    }
  }
  void openFaceBook()async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/303651683481268';
    } else {
      fbProtocolUrl = 'fb://page/303651683481268';
    }

    String fallbackUrl = 'https://www.facebook.com/303651683481268';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  String getURl(String url) {
    if (!url.contains('https://') &&
        !url.contains('http://') &&
        !url.contains('mailto:') &&
        !url.contains('tel:') &&
        !url.toLowerCase().contains('app-prefs:')) {
      url = 'https://' + url;
    }

    return url.replaceAll('http://', 'https://');
  }

  bool isPdfLink({required String url}) {
    if (url.isNotEmpty && url.contains('.')) {
      String extension = url.substring(url.lastIndexOf('.'));
      return extension.toLowerCase() == '.pdf';
    }
    return false;
  }
}
