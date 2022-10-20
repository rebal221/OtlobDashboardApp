// ignore_for_file: must_be_immutable

import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:otlab_controller/models_widgets/food_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/app_button_icon.dart';

class OrderFoodListWidget extends StatelessWidget {
  List<FoodWidgetModel> foods;
  double deliveryPrice;

  OrderFoodListWidget(
      {super.key, required this.foods, required this.deliveryPrice});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
          labelText: 'تفاصيل الطلبية',
          labelStyle: GoogleFonts.cairo(
              textStyle: TextStyle(
            color: HexColor(AppController.appData.value.secondColor),
            fontSize: 30.sp,
          )),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
        child: SizedBox(
            height: 400.h,
            width: 1600.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                    height: 370.h,
                    width: 1500.w,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsetsDirectional.zero,
                      elevation: 16,
                      child: Padding(
                        padding: EdgeInsets.all(0.r),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 20.h),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Card(
                                    elevation: 16,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsetsDirectional.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(50),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              ExtendedNetworkImageProvider(
                                            'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=768,574',
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: 90.w,
                                    child: Card(
                                      elevation: 16,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      color: HexColor(AppController
                                          .appData.value.secondColor),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.r),
                                        child: AppTextStyle(
                                          name: '#254792',
                                          color: Colors.white,
                                          textAlign: TextAlign.center,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              height: 280.h,
                              width: 370.w,
                              child: ListView(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shrinkWrap: true,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    color: AppColors.grey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 370.w,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 20.h),
                                            itemBuilder: (context, index) {
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: AppTextStyle(
                                                      name:
                                                          '${foods[index].count}',
                                                      color:
                                                          Colors.grey.shade800,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontSize: 24.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: AppTextStyle(
                                                      name: foods[index].name,
                                                      color:
                                                          Colors.grey.shade800,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        AppTextStyle(
                                                          name: foods[index]
                                                              .price
                                                              .toString(),
                                                          color:
                                                              AppColors.greyE,
                                                          textAlign:
                                                              TextAlign.end,
                                                          fontSize: 24.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        AppTextStyle(
                                                          name: 'ليرة',
                                                          color:
                                                              AppColors.greyE,
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                ],
                                              );
                                            },
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            itemCount: foods.length,
                                          ),
                                        ),
                                        Divider(
                                          height: 5.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: AppTextStyle(
                                                name: 'خدمة التوصيل',
                                                color: Colors.grey.shade800,
                                                textAlign: TextAlign.start,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  AppTextStyle(
                                                    name: deliveryPrice
                                                        .toString(),
                                                    color: AppColors.greyE,
                                                    textAlign: TextAlign.end,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppTextStyle(
                                                    name: 'ليرة',
                                                    color: AppColors.greyE,
                                                    textAlign: TextAlign.end,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: AppTextStyle(
                                                name: 'اجمالي الطلب',
                                                color: Colors.grey.shade800,
                                                textAlign: TextAlign.start,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  AppTextStyle(
                                                    name: '147',
                                                    color: AppColors.greyE,
                                                    textAlign: TextAlign.end,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppTextStyle(
                                                    name: 'ليرة',
                                                    color: AppColors.greyE,
                                                    textAlign: TextAlign.end,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
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
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            SizedBox(
                              height: 280.h,
                              width: 480.w,
                              child: ListView(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shrinkWrap: true,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    color: AppColors.grey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AppTextStyle(
                                                name: 'محمد ابراهيم عبد الرحيم',
                                                color: Colors.grey.shade900,
                                                textAlign: TextAlign.start,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              child: AppButtonIcon(
                                                  color: HexColor(AppController
                                                      .appData
                                                      .value
                                                      .secondColor),
                                                  icon: Icon(Icons.phone,
                                                      size: 15.r,
                                                      color: Colors.white),
                                                  title: 'اتصال بالعميل',
                                                  onPressed: () {}),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AppTextStyle(
                                                name:
                                                    '25 شارع الملكة - فيصل - الجيزة - الدور السادس - شقة 17',
                                                color: Colors.grey.shade900,
                                                textAlign: TextAlign.start,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Expanded(
                                              child: AppButtonIcon(
                                                  color: HexColor(AppController
                                                      .appData
                                                      .value
                                                      .secondColor),
                                                  icon: Icon(Icons.location_on,
                                                      size: 15.r,
                                                      color: Colors.white),
                                                  title: 'عنوان على الخريطة',
                                                  onPressed: () {}),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AppTextStyle(
                                                name: '01020114699',
                                                color: Colors.grey.shade900,
                                                textAlign: TextAlign.start,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 50.h,
                                                child: AppButton(
                                                    color: HexColor(
                                                        AppController
                                                            .appData
                                                            .value
                                                            .primaryColor),
                                                    title: 'قبول الطلب',
                                                    onPressed: () {}),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
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
                            ),
                          ],
                        ),
                      ),
                    )),

                ///myNewLine
              ],
            )),
      ),
    );
  }
}
