import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/force_update/force_update_model.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';

abstract class ForceUpdateRepository {
  Future<Either<Failure, ForceUpdateModel>> getForceUpdate();
}

class ApiForceUpdateRepository extends ForceUpdateRepository {
  @override
  Future<Either<Failure, ForceUpdateModel>> getForceUpdate() async {
    try {
      var result = await HttpWrapper(
          context: Get.context!,
          url: Apis.forceUpdate,
          showLoading: false,
          useScanLoading: false,
          postParameters: {}).get();
      if (result?.stringBody != null) {
        var body = json.decode(result!.stringBody!);
        if (body['code'] == 200) {
          ForceUpdateResponse response = ForceUpdateResponse.fromJson(body);
          return Right(response.result);
        } else {
          return Left(Failure(message: body['message']));
        }
      }
      return Left(Failure(message: S.of(Get.context!).generalError));
    } catch (_) {
      return Left(Failure(message: S.of(Get.context!).generalError));
    }
  }
}
