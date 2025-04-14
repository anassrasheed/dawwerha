import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/ads/list_ads_response.dart';
import 'package:raff/view_controllers/ads/repository/ads_repository.dart';

class MyAdsController extends GetxController {
  RxList<AdItem> items = <AdItem>[].obs;
  RxBool isLoading = true.obs;
  RxBool isFailed = false.obs;

  @override
  void onInit() {
    super.onInit();
    getMyAds();
  }

  void getMyAds() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      AdsRepository repository = ApiAdsRepository();
      var result = await repository.listOwnedAds();
      isLoading.value = false;
      if (result.isRight) {
        items.value = result.right;
      }
    } catch (_) {
      isLoading.value = false;
    }
  }
}
