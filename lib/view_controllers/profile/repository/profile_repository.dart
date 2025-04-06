import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/login/login_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/configuration/current_session.dart';
import 'package:raff/generated/l10n.dart';

abstract class ProfileRepository {
  Future<Either<Failure, LoginResponse>> updateProfile(
      String name, String zipCode,
      {bool showLoading = true});
}

class ApiProfileRepository extends ProfileRepository {
  @override
  Future<Either<Failure, LoginResponse>> updateProfile(
      String name, String zipCode,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.updateProfile,
        showLoading: showLoading,
        postParameters: {"fullName": name, "zipCode": zipCode}).post();
    if (result?.stringBody != null) {
      var body = json.decode(result!.stringBody!);
      if (body['code'] == 200) {
        LoginResponse response = LoginResponse.fromJson(body);
        CurrentSession().userModel = response.user!;
        return Right(response);
      } else {
        return Left(Failure(message: body['message'], errorCode: body['code']));
      }
    }
    return Left(Failure(message: S.of(Get.context!).generalError));
  }
}
