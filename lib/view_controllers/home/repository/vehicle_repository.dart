import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/view_controllers/home/model/vehicle_model.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<VehicleHistoryModel>>> getVehicleHistory();

  Future<Either<Failure, bool>> deleteAccount();
}

class ApiVehicleRepository extends VehicleRepository {
  @override
  Future<Either<Failure, List<VehicleHistoryModel>>> getVehicleHistory() async {
    try {
      var result = await HttpWrapper(
          context: Get.context!,
          url: Apis.scanHistory,
          showLoading: false,
          useScanLoading: false,
          postParameters: {}).get();
      if (result?.stringBody != null) {
        var body = json.decode(result!.stringBody!);
        if (body['code'] == 200) {
          VehicleHistoryResponse response =
              VehicleHistoryResponse.fromJson(body);
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

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      var result = await HttpWrapper(
          context: Get.context!,
          url: Apis.deleteAccount,
          showLoading: true,
          useScanLoading: false,
          postParameters: {}).post();
      if (result?.stringBody != null) {
        var body = json.decode(result!.stringBody!);
        if (body['code'] == 200) {
          return Right(true);
        } else {
          return Left(Failure(message: body['message']));
        }
      }
      return Left(Failure(message: S.of(Get.context!).generalError));
    } catch (e) {
      return Left(Failure(message: S.of(Get.context!).generalError));
    }
  }
}
