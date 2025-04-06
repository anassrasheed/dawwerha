import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/generated/l10n.dart';

class CameraHelper {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context, ValueChanged<XFile?> onPicked,
      {bool ignoreOptions = false}) async {
    if (ignoreOptions) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
        pickImage(context, onPicked, ignoreOptions: ignoreOptions);
      } else {
        final XFile? photo =
            await _picker.pickImage(source: ImageSource.camera);
        onPicked.call(photo);
      }
      return;
    }
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            S.of(context).camera,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: (_) async {
            Navigator.of(context, rootNavigator: true).maybePop();
            var status = await Permission.camera.status;
            if (status.isDenied) {
              await Permission.camera.request();
              pickImage(context, onPicked);
            } else {
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              onPicked.call(photo);
            }
          },
        ),
        BottomSheetAction(
          title: Text(
            S.of(context).gallery,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: (_) async {
            Navigator.of(context, rootNavigator: true).maybePop();
            var status = await Permission.storage.request();
            if (status.isDenied) {
              await Permission.storage.request();
              pickImage(context, onPicked);
            } else {
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              onPicked.call(photo);
            }
          },
        ),
      ],
      cancelAction: CancelAction(
          title: Text(
        S.of(context).dismiss,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
      )),
    );
  }
}

class ImageModel {
  String? assetImg;
  String? pathImage;
  String? onlineImage;
  String? attachmentsFileBytes;

  ImageModel({this.assetImg, this.pathImage, this.onlineImage});
}
