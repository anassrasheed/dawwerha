import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/common/generic_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/encryption_helper.dart';
import 'package:raff/utils/helpers/extensions.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, GenericResponse>> resetPassword(
      String mobileNumber, String password, String otpToken,
      {bool showLoading = true});
}

class ApiForgotPasswordRepository extends ForgotPasswordRepository {
  @override
  Future<Either<Failure, GenericResponse>> resetPassword(
      String mobileNumber, String password, String otpToken,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.resetPassword,
        showLoading: true, // 79639
        postParameters: {
          "phoneNumber": mobileNumber.generateValidMobileNumber(),
          "newPassword": EncryptionHelper().encryptValue(password),
          'otpToken': otpToken
        }).post();
    if (result?.stringBody != null) {
      var body = json.decode(result!.stringBody!);
      if (body['code'] == 200) {
        GenericResponse response = GenericResponse.fromJson(body);
        return Right(response);
      } else {
        return Left(Failure(message: body['message']));
      }
    }
    return Left(Failure(message: S.of(Get.context!).generalError));
  }
}
