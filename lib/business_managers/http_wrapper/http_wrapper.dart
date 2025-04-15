// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:raff/business_managers/api_model/common/api_response.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/configuration/general_configuration.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/l10n/app_locale.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/utils/ui/progress_hud.dart';
import 'package:raff/view_controllers/auth/auth_screen.dart';

class HttpWrapper {
  final String? url;
  final bool showLoading;
  final dynamic postParameters;
  final Map<String, String>? files;
  final Map<String, List<String?>>? filesList;
  final Duration defaultTimeout = const Duration(seconds: 120);
  final BuildContext? context;
  final String? token;
  final String currentLanguage;
  Map<String, String>? headers;
  final bool useAuthorization;
  final bool unFocusPrimary;
  final bool useScanLoading;

  HttpWrapper({
    this.headers,
    this.url,
    this.useAuthorization = true,
    this.useScanLoading = false,
    this.postParameters,
    this.files,
    this.filesList,
    this.context,
    this.token,
    this.currentLanguage = 'ar',
    this.showLoading = false,
    this.unFocusPrimary = true,
  }) {
    if (unFocusPrimary) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    headers ??= {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Accept-Language': AppLocale.shared.isArabic() ? '1' : '2',
    };

    if (CurrentSession().getUser() != null &&
        CurrentSession().getUser()!.accessToken != null) {
      headers!
        ..addAll({
          'Authorization':
              (CurrentSession().getUser()!.tokenType ?? 'Bearer').trim() +
                  ' ${CurrentSession().getUser()!.accessToken!}'
        });
    }
  }

  bool _validateUrl(HttpWrapper wrapper) {
    final validateUrl = Uri.tryParse(wrapper.url!);
    if (!GeneralConfigurations().isDebug && validateUrl!.scheme != 'https') {
      DialogUtils.showErrorDialog(
          buttonText: S.of(context!).ok,
          title: S.of(context!).warning,
          message: S.of(context!).generalError,
          context: wrapper.context!,
          callBack: () {
            exit(0);
          });
      return false;
    }

    return true;
  }

  // D:\flutter-sdk\flutter-.3.7.12\bin
  Future<HttpClient> _createClient(HttpWrapper wrapper) async {
    final clientContext = SecurityContext(withTrustedRoots: false);
    // if (wrapper.useAuthorization &&
    //     CurrentSession().currentModel?.data.token != null) {
    //   wrapper.headers!.putIfAbsent("Authorization", () => "Bearer " + CurrentSession().currentModel!.data.token);
    // }
    HttpClient client = HttpClient(context: clientContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        return true;
      });

    return client;
  }

  Future<ApiResponse?> put() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    try {
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .put(
        Uri.parse(this.url!),
        headers: this.headers,
        body: this.postParameters,
        encoding: utf8,
      )
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (this.showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _debugPrintLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (this.showLoading) {
          ProgressHud.shared.stopLoading();
        }
        _debugPrintLog('HTTP Exception', this);

        return Response(S.current.generalError, 500);
      });

      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
    }
    _debugPrintLog('PUT Request', this);
    if (apiResponse.statusCode == 403) {
      DialogUtils.showErrorDialog(
          title: S.of(g.Get.context!).warning,
          message: S.of(g.Get.context!).yourSessionIsExpiredPleaseLoginAgain,
          context: g.Get.context!,
          callBack: () {
            g.Get.offAll(AuthScreen());
          });

      return null;
    }
    return apiResponse;
  }

  Future<ApiResponse?> post() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    try {
      if (this.showLoading) {
        ProgressHud.shared
            .startLoading(this.context!, useScanLoading: useScanLoading);
      }
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .post(
        Uri.parse(this.url!),
        headers: this.headers,
        body: json.encode(this.postParameters),
        encoding: utf8,
      )
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (this.showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _debugPrintLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (this.showLoading) {
          ProgressHud.shared.stopLoading();
        }
        if (GeneralConfigurations().isDebug) {
          debugPrint('HTTP Exception $error');
        }

        return Response(S.current.generalError, 500);
      });
      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _debugPrintLog('POST Request', this);
    }
    _debugPrintLog('POST Request', this);
    if (apiResponse.statusCode == 403) {
      DialogUtils.showErrorDialog(
          title: S.of(g.Get.context!).warning,
          message: S.of(g.Get.context!).yourSessionIsExpiredPleaseLoginAgain,
          context: g.Get.context!,
          callBack: () {
            g.Get.offAll(AuthScreen());
          });

      return null;
    }
    return apiResponse;
  }

  Future<ApiResponse> startMultiPartPost() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;
    try {
      if (this.showLoading) {
        ProgressHud.shared.startLoading(this.context!);
      }
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept-Language': AppLocale.shared.isArabic() ? '1' : '2',
        // "Authorization": "Bearer ${CurrentSession().currentUser!.token!}"
      };
      var request = MultipartRequest('POST', Uri.parse(this.url!));
      request.fields.addAll(this.postParameters);
      for (var key in this.files!.keys) {
        // request.files.add(MultipartFile.fromBytes('file', await File.fromUri(Uri(path: wrapper.files![value]!)).readAsBytes(), contentType: MediaType('image', 'jpeg')));
        request.files.add(await MultipartFile.fromPath(
          key,
          this.files![key]!,
        ));
        // request.files.add(MultipartFile.fromBytes(
        //     'picture', File(wrapper.files![key]!).readAsBytesSync(),
        //     filename: wrapper.files![key]!.split("/").last));
      }

      request.headers.addAll(headers);

      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        apiResponse.statusCode = 200;
        String resp = await response.stream.bytesToString();
        apiResponse.body = utf8.encode(resp) as Uint8List?;
      } else {
        apiResponse.statusCode = response.statusCode;
      }
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      return apiResponse;
    } catch (_) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      return apiResponse;
    }
  }

  Future<ApiResponse> startMultiPartListPost() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;
    try {
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      var headers = {
        'Content-Type': 'multipart/form-data',
        'Accept-Language': AppLocale.shared.isArabic() ? '1' : '2',
        // "Authorization": "Bearer ${CurrentSession().currentUser!.token!}"
      };
      var request = MultipartRequest('POST', Uri.parse(this.url!));
      request.fields.addAll(this.postParameters);
      for (var key in this.filesList!.keys) {
        // request.files.add(MultipartFile.fromBytes('file', await File.fromUri(Uri(path: wrapper.files![value]!)).readAsBytes(), contentType: MediaType('image', 'jpeg')));
        for (var element in this.filesList![key]!) {
          request.files.add(await MultipartFile.fromPath(
            key,
            element!,
          ));
        }
        // request.files.add(MultipartFile.fromBytes(
        //     'picture', File(wrapper.files![key]!).readAsBytesSync(),
        //     filename: wrapper.files![key]!.split("/").last));
      }

      request.headers.addAll(headers);

      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        apiResponse.statusCode = 200;
        String resp = await response.stream.bytesToString();
        apiResponse.body = utf8.encode(resp) as Uint8List?;
      } else {
        apiResponse.statusCode = response.statusCode;
      }
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      return apiResponse;
    } catch (_) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      return apiResponse;
    }
  }

  Future<ApiResponse?> delete() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    try {
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .delete(
        Uri.parse(this.url!),
        headers: this.headers,
        body: json.encode(this.postParameters),
        encoding: utf8,
      )
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (this.showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _debugPrintLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (this.showLoading) {
          ProgressHud.shared.stopLoading();
        }
        if (GeneralConfigurations().isDebug) {
          debugPrint('HTTP Exception $error');
        }

        return Response(S.current.generalError, 500);
      });
      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _debugPrintLog('POST Request', this);
    }

    return apiResponse;
  }

  Future<ApiResponse?> get() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    try {
      // final bool _validUrl = _validateUrl(wrapper);
      //
      // if (!_validUrl) return _apiResponse;

      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .get(Uri.parse(this.url!), headers: this.headers)
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (this.showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _debugPrintLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (this.showLoading) {
          ProgressHud.shared.stopLoading();
        }
        _debugPrintLog('HTTP Exception', this);

        return Response(S.current.generalError, 500);
      });

      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _debugPrintLog('POST Request', this);
    }
    if (apiResponse.statusCode == 403) {
      DialogUtils.showErrorDialog(
          title: S.of(g.Get.context!).warning,
          message: S.of(g.Get.context!).yourSessionIsExpiredPleaseLoginAgain,
          context: g.Get.context!,
          callBack: () {
            g.Get.offAll(AuthScreen());
          });

      return null;
    }
    return apiResponse;
  }

  Future<ApiResponse?> getFile() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    try {
      final bool validUrl = _validateUrl(this);

      if (!validUrl) return apiResponse;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient.get(Uri.parse(this.url!));

      ioClient.close();

      apiResponse = ApiResponse();
      apiResponse.statusCode = response.statusCode;
      apiResponse.body = response.bodyBytes;
      apiResponse.stringBody = response.body;
    } catch (error) {
      if (this.showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _debugPrintLog('POST Request', this);
    }

    return apiResponse;
  }

  Future<ApiResponse> _finalResponse(
      HttpWrapper wrapper, Response response) async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    if (this.showLoading) ProgressHud.shared.stopLoading();

    final connectivityResult = await (Connectivity().checkConnectivity());

    try {
      _debugPrintLogWithResponse(response, wrapper);
    } catch (e) {
      if (GeneralConfigurations().isDebug) {
        debugPrint(e.toString());
      }
    }

    if (connectivityResult == ConnectivityResult.none) {
      return apiResponse;
    } else {
      apiResponse.statusCode = response.statusCode;
      apiResponse.body = response.bodyBytes;
      apiResponse.stringBody = response.body;

      return apiResponse;
    }
  }

  void _debugPrintLogWithResponse(Response response, HttpWrapper wrapper) {
    try {
      if (GeneralConfigurations().isDebug) {
        if (kDebugMode) {
          debugPrint(
              '${'==============================================\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url!}\n\npostBody = ' + wrapper.postParameters}\n\nresponse body = ${response.body}');
        }
        if (kDebugMode) {
          debugPrint('\n==============================================');
        }
      }
    } catch (_) {}
  }

  void _debugPrintLog(String from, HttpWrapper wrapper) {
    try {
      if (kDebugMode) {
        debugPrint(
            '==============================================\nFrom : $from\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url!}\n\npostBody = ${wrapper.postParameters}\n\n');
      }
      if (kDebugMode) {
        debugPrint('\n==============================================');
      }
    } catch (_) {}
  }
}
