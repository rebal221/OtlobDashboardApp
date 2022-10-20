// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';

import '../controller/cateogry_controller.dart';

class CategoryBody extends StatefulWidget {
  StateSetter setState;

  CategoryBody({super.key, required this.setState});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  Color pickerColor = HexColor(AppController.appData.value.primaryColor);
  Color currentColor = HexColor(AppController.appData.value.primaryColor);
  CategoryController controller = Get.find();
  CategoryControllerReadData controllerData = Get.find();

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
    log('dispose category body');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return myBodyWidget(context);
  }

  Widget myBodyWidget(context) {
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
                  labelText: 'قائمة المطاعم',
                  labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                    color: HexColor(AppController.appData.value.secondColor),
                    fontSize: 30.sp,
                  )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                child: SizedBox(
                  height: 400.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 250.h,
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  end: 5.w, start: 0, top: 3.h),
                              height: 250.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                  color: HexColor(controllerData
                                      .listCategory.value[index].color
                                      .toString()),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Stack(
                                children: [
                                  PositionedDirectional(
                                    top: 0,
                                    end: 5,
                                    start: -10,
                                    bottom: 0,
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      child: SizedBox(
                                        height: 120.h,
                                        width: 110.w,
                                        child: ImageNetwork(
                                            imageCache:
                                                CachedNetworkImageProvider(
                                                    controllerData.listCategory
                                                        .value[index].image
                                                        .toString()),
                                            image: controllerData
                                                .listCategory.value[index].image
                                                .toString(),
                                            height: 170,
                                            width: 170),
                                      ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: 0,
                                    end: 5,
                                    start: -10,
                                    bottom: 0,
                                    child: Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: SizedBox(
                                        height: 120.h,
                                        width: 110.w,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: AppTextStyle(
                                            name: controllerData
                                                .listCategory.value[index].name
                                                .toString(),
                                            color: AppColors.white,
                                            fontSize: 22.sp,
                                            isMarai: false,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: AppButton(
                              color: HexColor(
                                  AppController.appData.value.primaryColor),
                              borderRadiusButton: 5,
                              title: 'تعديل',
                              onPressed: () => controller.onClickUpdate(
                                  controllerData.listCategory[index]),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: 150.w,
                            height: 50.h,
                            child: AppButton(
                                borderRadiusButton: 5,
                                title: 'حذف',
                                onPressed: () => controller.deleteCategory(
                                    controllerData
                                        .listCategory.value[index].uid),
                                color: Colors.grey.shade900),
                          ),
                        ],
                      );
                    },
                    itemCount: controllerData.listCategory.value.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 50.w,
            ),

            /// here add and update widget
            FadeInUp(
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                  labelText: CategoryController.isClickedUpdate.value
                      ? 'تعديل تصنيف'
                      : 'اضافة تصنيف جديدة',
                  labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                    color: HexColor(AppController.appData.value.secondColor),
                    fontSize: 30.sp,
                  )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                child: SizedBox(
                    height: 430.h,
                    width: 1600.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldAdd(
                                width: 400.w,
                                tittle: 'اسم التصنيف',
                                hint: 'أدخل اسم التصنيف. مثال (حلويات)',
                                controller: controller.name,
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
                                            name: 'لون الخلفية للتصنيف',
                                            fontSize: 22.sp,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showAlertDialogColor();
                                            },
                                            child: SizedBox(
                                                height: 60.h,
                                                width: 200.w,
                                                child: Card(
                                                  color: HexColor(
                                                      controller.color.value),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 200.h,
                              width: 850.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextStyle(
                                    name: 'صورة التصنيف',
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
                                        width: 180.w,
                                        height: 150.h,
                                        child: controller.image.value.isEmpty
                                            ? Card(
                                                child: InkWell(
                                                onTap: () =>
                                                    controller.uploadImage(),
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
                                                    controller.uploadImage(),
                                                child: CustomImageNetwork(
                                                  width: 180.w,
                                                  height: 150.h,
                                                  imageUrl:
                                                      controller.image.value,
                                                  boxFit: BoxFitWeb.contain,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              name:
                                  'أبعاد الصورة يجب أن تكون (80px  - 114px) بصيغة PNG',
                              fontSize: 22.sp,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                      width: 140.w,
                                      child: AppButton(
                                          isLoading: CategoryController
                                              .isLoading.value,
                                          color: HexColor(AppController
                                              .appData.value.primaryColor),
                                          title: CategoryController
                                                  .isClickedUpdate.value
                                              ? 'تعديل التصنيف'
                                              : 'اضافة التصنيف',
                                          onPressed: () async {
                                            if (CategoryController
                                                .isClickedUpdate.value) {
                                              await controller.updateCategory();
                                            } else {
                                              await controller.addCategory();
                                            }
                                          }),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 140.w,
                                      child: AppButton(
                                          title: 'الغاء',
                                          onPressed: () =>
                                              controller.clearData(),
                                          color: Colors.grey.shade800),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                  ],
                                ),
                              ],
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

  void showAlertDialogColor() {
    showDialog(
        context: context,
        builder: (_) {
          void changeColor(Color color) {
            setState(() => pickerColor = color);
          }

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              title: const Text('اختيار اللون'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                AppButton(
                    color: pickerColor,
                    title: 'اختيار اللون',
                    onPressed: () {
                      String a = pickerColor.toHex();
                      String finalColor = a.replaceRange(1, 3, '');

                      //ToDo: here save color in object
                      controller.color.value = finalColor;
                      log(finalColor);
                      Get.back();
                    })
              ],
            );
          });
        });
  }
}
