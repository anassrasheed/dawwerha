import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/common/generic_response.dart';
import 'package:raff/business_managers/api_model/otp/verify_otp_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/encryption_helper.dart';
import 'package:raff/utils/helpers/extensions.dart';

enum OTPType { EMAIL_VERIFICATION, PASSWORD_RESET }

abstract class OtpRepository {
  Future<Either<Failure, GenericResponse>> requestOtp(
      String mobileNumber, OTPType type,
      {bool showLoading = true});

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      String mobileNumber, OTPType type, String otpCode,
      {bool showLoading = true});
}

class ApiOtpRepository extends OtpRepository {
  @override
  Future<Either<Failure, GenericResponse>> requestOtp(
      String mobileNumber, OTPType type,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.generateCode,
        showLoading: showLoading,
        postParameters: {
          "phoneNumber": mobileNumber.generateValidMobileNumber(),
          "otpType": type.name
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

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(
      String mobileNumber, OTPType type, String otpCode,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.verifyCode,
        showLoading: showLoading,
        postParameters: {
          "phoneNumber": mobileNumber.generateValidMobileNumber(),
          "otpType": type.name,
          'otpCode': EncryptionHelper().encryptValue(otpCode)
        }).post();
    if (result?.stringBody != null) {
      var body = json.decode(result!.stringBody!);
      if (body['code'] == 200) {
        VerifyOtpResponse response = VerifyOtpResponse.fromJson(body);
        return Right(response);
      } else {
        return Left(Failure(message: body['message'], errorCode: body['code']));
      }
    }
    return Left(Failure(message: S.of(Get.context!).generalError));
  }
}
