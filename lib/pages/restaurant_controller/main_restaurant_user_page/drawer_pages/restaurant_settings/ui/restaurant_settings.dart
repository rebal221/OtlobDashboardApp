// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:flutter_animator/flutter_animator.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/drop_down_serach_category.dart';
import 'package:otlab_controller/widget/product_count.dart';

class RestaurantSettingsBody extends StatefulWidget {
  StateSetter setState;

  RestaurantSettingsBody({super.key, required this.setState});

  @override
  State<RestaurantSettingsBody> createState() => _RestaurantSettingsBodyState();
}

class _RestaurantSettingsBodyState extends State<RestaurantSettingsBody> {
  final _formKeyDropDownCategory = GlobalKey<FormState>();
  RestaurantSettingsController controller = Get.find();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log('dispose settings');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView(
          shrinkWrap: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // controller: controller,
          children: [
            SizedBox(
              height: 50.h,
              width: 50.w,
            ),
            FadeInUp(
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                  labelText: 'اعدادات المطعم',
                  labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                    color: HexColor(AppController.appData.value.secondColor),
                    fontSize: 30.sp,
                  )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                child: SizedBox(
                    height: 860.h,
                    width: 1600.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),

                        ///myNewLine

                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                tittle: 'اسم المطعم',
                                hint: 'أدخل اسم المطعم',
                                height: 100,
                                heightSizeBox: 160,
                                controller: controller.nameRestaurant,
                                type: TextInputType.text,
                                enable: false,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            SizedBox(
                              height: 140.h,
                              width: 400.w,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 140.h,
                                      width: 400.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextStyle(
                                            name: 'اختر تصنيف المطعم',
                                            fontSize: 22.sp,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SizedBox(
                                            height: 70.h,
                                            child: DropDownSearchCategory(
                                              categoryModel: controller
                                                  .selectedCategory.value,
                                              formKey: _formKeyDropDownCategory,
                                              onSaved:
                                                  (CategoryModel? value) {},
                                              onChange:
                                                  (CategoryModel? value) async {
                                                if (value != null) {
                                                  controller.selectedCategory
                                                      .value = value;
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                tittle: 'عنوان المطعم',
                                hint: 'أدخل عنوان المطعم',
                                height: 100,
                                heightSizeBox: 160,
                                controller: controller.adderssRestaurant,
                                type: TextInputType.streetAddress,
                                enable: false,
                              ),
                            ),
                          ],
                        ),

                        ///myNewLine

                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                tittle: 'وصف مختصر عن المطعم',
                                hint: 'أدخل وصف مختصر عن المطعم',
                                controller: controller.descriptionRestaurant,
                                type: TextInputType.multiline,
                                height: 130,
                                heightSizeBox: 170,
                                enable: false,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            SizedBox(
                              height: 220.h,
                              width: 850.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextStyle(
                                    name: 'صور للمطعم',
                                    fontSize: 22.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        height: 150.h,
                                        child: controller.imageOne.value.isEmpty
                                            ? Card(
                                                child: InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(1),
                                                child: Center(
                                                  child: Icon(
                                                      Icons
                                                          .photo_size_select_actual_rounded,
                                                      color: Colors.black,
                                                      size: 75.r),
                                                ),
                                              ))
                                            : InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(1),
                                                child: CustomImageNetwork(
                                                  width: 150.w,
                                                  height: 150.h,
                                                  imageUrl:
                                                      controller.imageOne.value,
                                                  boxFit: BoxFitWeb.contain,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),

                                      SizedBox(
                                        width: 150.w,
                                        height: 150.h,
                                        child: controller.imageTow.value.isEmpty
                                            ? Card(
                                                child: InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(2),
                                                child: Center(
                                                  child: Icon(
                                                      Icons
                                                          .photo_size_select_actual_rounded,
                                                      color: Colors.black,
                                                      size: 75.r),
                                                ),
                                              ))
                                            : InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(2),
                                                child: CustomImageNetwork(
                                                  width: 150.w,
                                                  height: 150.h,
                                                  imageUrl:
                                                      controller.imageTow.value,
                                                  boxFit: BoxFitWeb.contain,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                        height: 150.h,
                                        child: controller
                                                .imageThree.value.isEmpty
                                            ? Card(
                                                child: InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(3),
                                                child: Center(
                                                  child: Icon(
                                                      Icons
                                                          .photo_size_select_actual_rounded,
                                                      color: Colors.black,
                                                      size: 75.r),
                                                ),
                                              ))
                                            : InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(2),
                                                child: CustomImageNetwork(
                                                  width: 150.w,
                                                  height: 150.h,
                                                  imageUrl: controller
                                                      .imageThree.value,
                                                  boxFit: BoxFitWeb.contain,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),

                                      //ToDo: here from price and to price
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        //ToDo: new line

                        ///myNewLine
                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                height: 100,
                                heightSizeBox: 160,
                                tittle: 'رسوم التوصيل',
                                hint: 'أدخل قيمة رسوم التوصيل',
                                controller: controller.pricingDelivery,
                                type: TextInputType.text,
                                enable: false,
                              ),
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 0.w,
                            ),
                            SizedBox(
                              height: 200.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 120.w,
                                    child: TextFieldAdd(
                                      width: 100.w,
                                      widthSizeBox: 100.w,
                                      tittle: 'متوسط الاسعار',
                                      hint: 'من',
                                      height: 100,
                                      heightSizeBox: 160,
                                      textAlign: TextAlign.center,
                                      controller: controller.pricingFrom,
                                      type: TextInputType.number,
                                      enable: false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: TextFieldAdd(
                                      width: 90.w,
                                      height: 100,
                                      heightSizeBox: 160,
                                      widthSizeBox: 90.w,
                                      tittle: '',
                                      hint: 'الى',
                                      textAlign: TextAlign.center,
                                      controller: controller.pricingTow,
                                      type: TextInputType.number,
                                      enable: false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15),
                                      AppTextStyle(
                                        name: 'وسائل الدفع',
                                        fontSize: 22.sp,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 70.h,
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: AppColors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: SizedBox(
                                            width: 150.w,
                                            height: 70.h,
                                            child: GetBuilder<
                                                RestaurantSettingsController>(
                                              assignId: true,
                                              builder: (logic) {
                                                return ListView.builder(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .paymentMethodList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Center(
                                                        child: SizedBox(
                                                          height: 70.h,
                                                          width: 150.w,
                                                          child: Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            child: Obx(() {
                                                              return CheckboxListTile(
                                                                enabled: false,
                                                                selected: controller
                                                                    .paymentMethodList[
                                                                        index]
                                                                    .value
                                                                    .active,
                                                                activeColor: HexColor(
                                                                    AppController
                                                                        .appData
                                                                        .value
                                                                        .primaryColor),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r)),
                                                                checkColor:
                                                                    Colors
                                                                        .white,
                                                                value: controller
                                                                    .paymentMethodList[
                                                                        index]
                                                                    .value
                                                                    .active,
                                                                onChanged:
                                                                    (value) {
                                                                  controller.updateSelectedValue(
                                                                      value,
                                                                      index,
                                                                      controller
                                                                          .paymentMethodList[
                                                                              index]
                                                                          .value
                                                                          .tittle);
                                                                },
                                                                title:
                                                                    CustomSvgImage(
                                                                  imageName: controller
                                                                      .paymentMethodList[
                                                                          index]
                                                                      .value
                                                                      .imagePath,
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ///myNewLine

                        Row(
                          children: [
                            SizedBox(
                              height: 140.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextStyle(
                                    name: 'أوقات عمل المطعم',
                                    fontSize: 22.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 200.w,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppTextStyle(
                                              name: 'الى',
                                              color: Colors.grey.shade300,
                                              fontSize: 16.sp,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ProductCount(
                                              icon: Icons.remove,
                                              count: () {
                                                controller
                                                    .clickToPickTime(context);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            InkWell(
                                              onTap: () => controller
                                                  .clickToPickTime(context),
                                              child: AppTextStyle(
                                                name: controller
                                                    .timeToAsString.value,
                                                color: Colors.grey.shade800,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ProductCount(
                                              icon: Icons.add,
                                              count: () {
                                                controller
                                                    .clickToPickTime(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            SizedBox(
                              height: 140.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextStyle(
                                    name: '',
                                    fontSize: 22.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 200.w,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppTextStyle(
                                              name: 'من',
                                              color: Colors.grey.shade300,
                                              fontSize: 16.sp,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ProductCount(
                                              icon: Icons.remove,
                                              count: () {
                                                controller
                                                    .clickFromPickTime(context);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            InkWell(
                                              onTap: () => controller
                                                  .clickFromPickTime(context),
                                              child: AppTextStyle(
                                                name: controller
                                                    .timeFromAsString.value,
                                                color: Colors.grey.shade800,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ProductCount(
                                              icon: Icons.add,
                                              count: () {
                                                controller
                                                    .clickFromPickTime(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            SizedBox(
                              height: 140.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextStyle(
                                    name: 'الحجز المسبق ؟',
                                    fontSize: 22.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 200.w,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: SizedBox(
                                          height: 70.h,
                                          width: 200.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Obx(() {
                                              return CheckboxListTile(
                                                  selected: controller
                                                      .isAdvanceReservation
                                                      .value,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0.h),
                                                  activeColor: HexColor(
                                                      AppController.appData
                                                          .value.primaryColor),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r)),
                                                  checkColor: Colors.white,
                                                  value: controller
                                                      .isAdvanceReservation
                                                      .value,
                                                  onChanged: (value) {
                                                    controller
                                                        .isAdvanceReservation
                                                        .value = value!;
                                                  },
                                                  title: const AppTextStyle(
                                                    name: 'تفعيل',
                                                    color: AppColors.black,
                                                    textAlign: TextAlign.center,
                                                  ));
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                tittle: 'رقم التواصل',
                                hint: 'أدخل رقم التواصل',
                                height: 100,
                                heightSizeBox: 140,
                                controller: controller.number,
                                type: TextInputType.number,
                                enable: false,
                              ),
                            ),
                          ],
                        ),

                        ///myNewLine
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            // clockWidget(),
                            SizedBox(
                              height: 70.h,
                              width: 140.w,
                              child: AppButton(
                                  isLoading: RestaurantSettingsController
                                      .isLoading.value,
                                  color: HexColor(
                                      AppController.appData.value.primaryColor),
                                  title: 'حفظ الاعدادات',
                                  onPressed: () =>
                                      controller.completeAccountData()),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }
}
