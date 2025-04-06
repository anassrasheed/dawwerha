import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/common/failure.dart';
import 'package:raff/business_managers/api_model/vehicle_response/vehicle_model.dart';
import 'package:raff/business_managers/apis.dart';
import 'package:raff/business_managers/http_wrapper/http_wrapper.dart';
import 'package:raff/generated/l10n.dart';

abstract class ScanVinNumberRepository {
  Future<Either<Failure, List<Category>>> scanVin(String vinNumber,
      {bool showLoading = true});
}

class ApiScanVinNumberRepository extends ScanVinNumberRepository {
  @override
  Future<Either<Failure, List<Category>>> scanVin(String vinNumber,
      {bool showLoading = true}) async {
    try {
      var result = await HttpWrapper(
          context: Get.context!,
          url: Apis.scanVin,
          showLoading: showLoading,
          useScanLoading: true,
          postParameters: {"vehicleNumber": vinNumber}).post();
      if (result?.stringBody != null) {
        var body = json.decode(result!.stringBody!);
        if (body['code'] == 200) {
          VehicleResponse response = VehicleResponse.fromJson(body);
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

  List<Category> _filter(List<Category> result) {
    return result
        .map((category) {
      List<CatValue> filteredValues = category.values
          .where((value) => value.value != null && value.value!.isNotEmpty)
          .toList();

      if (filteredValues.isNotEmpty) {
        return Category(
          category: category.category,
          values: filteredValues,
          image: category.image,
        );
      } else {
        return null;
      }
    })
        .whereType<Category>()
        .toList();
  }

}
