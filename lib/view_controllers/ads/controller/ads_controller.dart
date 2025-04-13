import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raff/generated/l10n.dart';
import 'package:raff/utils/ui/dialog_utils.dart';
import 'package:raff/view_controllers/ads/repository/ads_repository.dart';

class AdsController extends GetxController {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  Rx<XFile?> _image = Rx<XFile?>(null);

  FocusNode titleFocus = FocusNode();
  FocusNode descFocus = FocusNode();
  FocusNode addressFocus = FocusNode();

  RxString titleError = ''.obs;
  RxString descError = ''.obs;
  RxString addressError = ''.obs;

  void setPickedImage(XFile img) {
    _image.value = img;
    _image.refresh();
  }

  Rx<XFile?> get image => _image;

  void saveAds() async {
    AdsRepository repository = ApiAdsRepository();
    final result = await repository.addAds(
        titleController.text,
        descController.text,
        addressController.text,
        await convertImageToBase64(image.value!));
    if (result.isRight) {
      DialogUtils.showToastView(
          Get.context!, S.of(Get.context!).yourAdsHasAddedSuccessfully,
          type: DialogType.error);
      Get.back();
    } else {
      DialogUtils.showToastView(Get.context!, result.left.message,
          type: DialogType.error);
    }
  }

  Future<String> convertImageToBase64(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }
}
