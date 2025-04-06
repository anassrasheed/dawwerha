// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raff/utils/helpers/string_helper.dart';

class LogsManager {
  // TODO: DON'T FORGET TO CHANGE THIS TO FALSE BEFORE LIVE :)
  static const bool enableDebugMode = true;
  static const bool enableDemoMode = false;

  static void debugPrintLog({
    required String message,
    dynamic senderClass,
    Object? object,
  }) {
    if (enableDebugMode) {
      final _dateTime = DateTime.now();

      if (object != null) {
        debugPrint(
            'Log Date: ${_dateTime.toString()} ==== Sender Class ==== ${senderClass.toString()} ==== Logged Data ==== ${message.toString()} ==== sent object ==== ${object.toString()}');
      } else {
        debugPrint(
            'Log Date: ${_dateTime.toString()} ==== Sender Class ==== ${senderClass.toString()} ==== Logged Data ==== ${message.toString()}');
      }
    }
  }

  static void debugPrintLogWithResponse({
    String? response,
    dynamic postParameters,
    dynamic url,
    dynamic headers,
  }) {
    if (enableDebugMode) {
      var _body = postParameters is String
          ? postParameters
          : jsonEncode(postParameters);

      _body = StringHelper.shared.replaceArabicNumbers(arabic: _body);

      final _dateTime = DateTime.now();

      debugPrint('==============================================' +
          '\n' +
          'Date Time = ${_dateTime.toString()}' +
          '\n\n' +
          'encoding = UTF8' +
          '\n\n' +
          'url =' +
          url.toString() +
          '\n\n' +
          'headers =' +
          headers.toString() +
          '\n\n' +
          'postBody = ' +
          (_body) +
          '\n\n' +
          'response body = ' +
          response!);
      debugPrint('\n==============================================');
    }
  }

  static void debugPrintLogWithoutResponse({
    dynamic message,
    dynamic postParameters,
    dynamic url,
    dynamic headers,
  }) {
    if (enableDebugMode) {
      var _body = postParameters is String
          ? postParameters
          : jsonEncode(postParameters);
      _body = StringHelper.shared.replaceArabicNumbers(arabic: _body);
      final _dateTime = DateTime.now();

      debugPrint('==============================================' +
          '\n' +
          'Date Time = ${_dateTime.toString()}' +
          '\n\n' +
          'message = ' +
          message.toString() +
          '\n\n' +
          'encoding = UTF8' +
          '\n\n' +
          'url =' +
          url.toString() +
          '\n\n' +
          'headers =' +
          headers.toString() +
          '\n\n' +
          'postBody = ' +
          _body.toString());
      debugPrint('\n==============================================');
    }
  }
}
