import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/ads/list_ads_response.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
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

  void fetchMyAds() async {
    try {
      AdsRepository repository = ApiAdsRepository();
      var result = await repository.listOwnedAds();
      if (result.isRight) {
        items.value = result.right;
      }
    } catch (_) {
      isLoading.value = false;
    }
  }

  void deleteMyAds(int wareId) async {
    try {
      AdsRepository repository = ApiAdsRepository();
      var result = await repository.deleteAds(wareId: wareId);
      isLoading.value = false;
      if (result.isRight) {
        fetchMyAds();
        DialogUtils.showToastView(
            Get.context!, S.of(Get.context!).yourItemHasDeletedSuccessfully,
            type: DialogType.success);
      }
    } catch (_) {
      isLoading.value = false;
    }
  }
  void changeAdStatus(int wareId) async {
    try {
      AdsRepository repository = ApiAdsRepository();
      var result = await repository.changeAdStatus(wareId: wareId);
      isLoading.value = false;
      if (result.isRight) {
        fetchMyAds();
      }
    } catch (_) {
      isLoading.value = false;
    }
  }
}
