import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/login/login_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/encryption_helper.dart';
import 'package:raff/utils/helpers/extensions.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> login(String mobileNumber, String password,
      {bool showLoading = true});
}

class ApiLoginRepository extends LoginRepository {
  @override
  Future<Either<Failure, UserModel>> login(String mobileNumber, String password,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.login,
        showLoading: showLoading,
        postParameters: {
          "phoneNumber": mobileNumber.generateValidMobileNumber(),
          "password": EncryptionHelper().encryptValue(password)
        }).post();
    if (result?.stringBody != null) {
      var body = json.decode(result!.stringBody!);
      if (body['code'] == 200) {
        LoginResponse response = LoginResponse.fromJson(body);
        return Right(response.user!);
      } else {
        return Left(Failure(message: body['message']));
      }
    }
    return Left(Failure(message: S.of(Get.context!).generalError));
  }
}
