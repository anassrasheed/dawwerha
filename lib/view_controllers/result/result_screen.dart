import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:raff/business_managers/api_model/vehicle_response/vehicle_model.dart';
import 'package:raff/configuration/app_colors.dart';
import 'package:raff/utils/ui/list_tab_view/scrollable_list_tabview.dart';
import 'package:sizer/sizer.dart';

import '../../utils/ui/custom_container.dart';
import '../../utils/ui/custom_text.dart';

class ResultScreen extends StatefulWidget {
  final List<Category> categories;
  final String vin;
  final String vehicleName;
  final String? vehicleType;

  ResultScreen(
      {super.key,
      required this.categories,
      required this.vin,
      required this.vehicleName,
      this.vehicleType});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 20.w,
                      color: Colors.transparent,
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                      child: SvgPicture.asset('assets/ic-close.svg'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    text: widget.vin.toUpperCase().replaceAll(' ', ''),
                    fontSize: 16,
                    color: Colors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomText(
                  text: widget.vehicleName,
                  fontSize: 22,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.vehicleType != null && widget.vehicleType!.isNotEmpty)
                SizedBox(
                  height: 11,
                ),
              if (widget.vehicleType != null && widget.vehicleType!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomText(
                    text: widget.vehicleType!,
                    textAlign: TextAlign.start,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Expanded(
                          child: ScrollableListTabView(
                            tabHeight: 50,
                            tabs: widget.categories.map((e) {
                              return ScrollableListTab(
                                  tab: ListTab(
                                      label: e.category,
                                      innerTabIcon: SvgPicture.asset(e.image),
                                      borderRadius: BorderRadius.circular(20),
                                      borderColor: AppColors().chipColor,
                                      inactiveBackgroundColor:
                                          Color(0xffEDF5FF),
                                      activeBackgroundColor:
                                          AppColors.primaryColor),
                                  body: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: e.values.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index) {
                                      if (e.values[index].value != null &&
                                          e.values[index].value!.isNotEmpty)
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: e.values[index].key,
                                              textAlign: TextAlign.start,
                                              color: Color(0xff959595),
                                              fontSize: 15,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            _buildValue(e, index),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        );
                                      return SizedBox.shrink();
                                    },
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValue(Category e, int index) {
    return Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Color(0xffE9F1F5), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: e.values[index].value!,
                fontSize: 15,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ));
  }
}
