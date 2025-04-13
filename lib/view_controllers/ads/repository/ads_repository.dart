import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/common/generic_response.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';

abstract class AdsRepository {
  Future<Either<Failure, GenericResponse>> addAds(
      String title, String desc, String address, String img,
      {bool showLoading = true});

  Future<Either<Failure, GenericResponse>> listAds({bool showLoading = true});
}

class ApiAdsRepository extends AdsRepository {
  @override
  Future<Either<Failure, GenericResponse>> addAds(
      String title, String desc, String address, String base64,
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.addAds,
        showLoading: true,
        postParameters: {
          "title": "$title",
          "description": "$desc",
          "address": "$address",
          "base64Image": "$base64",
          "active": true
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
  Future<Either<Failure, GenericResponse>> listAds(
      {bool showLoading = true}) async {
    var result = await HttpWrapper(
        context: Get.context!,
        url: Apis.addAds,
        showLoading: true,
        postParameters:{}).post();
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
