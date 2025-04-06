import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/common/generic_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/helpers/encryption_helper.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, GenericResponse>> changePassword(
      String oldPassword, String newPassword,
      {bool showLoading = true});
}

class ApiChangePasswordRepository extends ChangePasswordRepository {
  @override
  Future<Either<Failure, GenericResponse>> changePassword(
      String oldPassword, String newPassword,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.changePassword,
        showLoading: true,
        postParameters: {
          "oldPassword": EncryptionHelper().encryptValue(oldPassword),
          "newPassword": EncryptionHelper().encryptValue(newPassword)
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
