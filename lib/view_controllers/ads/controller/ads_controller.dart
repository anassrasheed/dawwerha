import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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


  void _resetErrors(){
    titleError.value='';
    descError.value='';
    addressError.value='';
  }
  void saveAds() async {
    _resetErrors();
    if (_image.value == null) {
      DialogUtils.showErrorDialog(
          title: S.of(Get.context!).warning,
          message: S.of(Get.context!).pleaseUploadAPlasticImage,
          context: Get.context!);
      return;
    }
    if (titleController.text.isEmpty) {
      titleError.value = S.of(Get.context!).thisFieldIsRequired;
      titleFocus.requestFocus();
      return;
    }
    if (descController.text.isEmpty) {
      descError.value = S.of(Get.context!).thisFieldIsRequired;
      descFocus.requestFocus();
      return;
    }
    if (addressController.text.isEmpty) {
      addressError.value = S.of(Get.context!).thisFieldIsRequired;
      addressFocus.requestFocus();
      return;
    }

    AdsRepository repository = ApiAdsRepository();
    final result = await repository.addAds(
        titleController.text,
        descController.text,
        addressController.text,
        await convertImageToBase64(
            (await compressImage(File(image!.value!.path)))!));
    if (result.isRight) {
      DialogUtils.showToastView(
          Get.context!, S.of(Get.context!).yourAdsHasAddedSuccessfully,
          type: DialogType.success);
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

  Future<XFile?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50, // 0-100 (lower = more compression)
    );

    return result;
  }
}
