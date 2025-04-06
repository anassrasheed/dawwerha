import 'package:flutter/material.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:sizer/sizer.dart';

class DecoratedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleLabel;
  final String? bgImage;
  final bool showBack;
  final double? fontSize;
  final Widget? subTitle;
  final VoidCallback? onBackPressed;
  DecoratedAppBar(
      {super.key,
      required this.titleLabel,
      this.bgImage,
      this.onBackPressed,
      this.fontSize,
      this.subTitle,
      this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: bgImage == null
          ? Container()
          : Image(
              image: AssetImage(bgImage!),
              fit: BoxFit.fitHeight,
            ),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          children: [
            showBack
                ? GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 4.h,
                      width: 4.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: 8.0, start: 12.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 13.sp,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (onBackPressed != null)
                        onBackPressed!.call();
                      else
                        Navigator.pop(context);
                    },
                  )
                : Container(),
            SizedBox(
              width: 3.5.w,
            ),
            Text(titleLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors().blackTextColor,
                  fontSize: fontSize ?? 14.sp,
                )),
            if (subTitle != null) Spacer(),
            if (subTitle != null) subTitle!,
          ],
        ),
      ),
      toolbarHeight: 12.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(100.w, 12.h);
}
