// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter_animator/flutter_animator.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/body_page/main_restaurant_user_page.dart';
import 'package:otlab_controller/pages/restaurant_controller/order_details_page/ui/order_details_page.dart';

class ControllerRestaurantBody extends StatefulWidget {
  StateSetter setState;

  ControllerRestaurantBody({super.key, required this.setState});

  @override
  State<ControllerRestaurantBody> createState() =>
      _ControllerRestaurantBodyState();
}

class _ControllerRestaurantBodyState extends State<ControllerRestaurantBody> {
  ScrollController controller1 = ScrollController();

  List<String> listAdded = [
    // 'اضافة قائمة طعام جديدة',
    'اضافة وجبة جديدة',
    'اضافة خصم جديد',
  ];

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
  Widget build(BuildContext context) {
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
          FadeInLeft(
            child: SizedBox(
              height: 250.h,
              width: 600.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      log('onTap');
                      if (index == 0) {
                        //ToDo: get to food list
                        MainRestaurantPageState.stateSetter(() {
                          MainRestaurantPage.selectedIndex = 1;
                          MyBodyRestaurantState.selectedIndex = 1;
                          MainRestaurantPageState.isClickToOrderDetails = false;

                          if (mounted) {
                            setState(() {});
                          }

                          debugPrint(
                              'selectedIndex Drawer Model ${MainRestaurantPage.selectedIndex}');
                          debugPrint('index Drawer Model $index');
                          debugPrint('index Drawer Model $index');
                          debugPrint(
                              'isClickToOrderDetails ${MainRestaurantPageState.isClickToOrderDetails}');
                        });
                      } else {
                        //ToDo:get to discount page
                        MainRestaurantPageState.stateSetter(() {
                          MainRestaurantPage.selectedIndex = 2;
                          MyBodyRestaurantState.selectedIndex = 2;
                          MainRestaurantPageState.isClickToOrderDetails = false;
                          if (mounted) {
                            setState(() {});
                          }

                          debugPrint(
                              'selectedIndex Drawer Model ${MainRestaurantPage.selectedIndex}');
                          debugPrint('index Drawer Model $index');
                          debugPrint('index Drawer Model $index');
                          debugPrint(
                              'isClickToOrderDetails ${MainRestaurantPageState.isClickToOrderDetails}');
                        });
                      }
                    },
                    child: SizedBox(
                        height: 250.h,
                        width: 169.w,
                        child: Card(
                          elevation: 16,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              HexColor(AppController.appData.value.secondColor),
                          child: ListView(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 53.h,
                              ),
                              Icon(
                                Icons.add_circle_rounded,
                                color: HexColor(
                                    AppController.appData.value.primaryColor),
                                size: 45.r,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: AppTextStyle(
                                  textAlign: TextAlign.center,
                                  name: listAdded[index].toString(),
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 35.w,
                  );
                },
                itemCount: listAdded.length,
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
            width: 50.w,
          ),
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'الطلبات الجديدة',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                height: 450.h,
                width: 1600.w,
                child: GridView.builder(
                  controller: controller1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 169.w / 38.h,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(OrderDetailsBody(setState: setState));
                      },
                      child: SizedBox(
                          height: 160.h,
                          width: 169.w,
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                // controller: controller2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    width: 420.w,
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      color: AppColors.grey,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.r),
                                        child: AppTextStyle(
                                          name:
                                              '3 سندوتشات شاورما حجم وسط + 2 بيبسي كولا + 3 باكت بطاطس + 1 عصير مانجو فريش',
                                          color: HexColor(AppController
                                              .appData.value.secondColor),
                                          textAlign: TextAlign.start,
                                          fontSize: 18.sp,
                                          isMarai: false,
                                          count: 4,
                                          maxLines: 4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    color: AppColors.grey,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            AppTextStyle(
                                              name: 'قيمة الطلب ',
                                              color: HexColor(AppController
                                                  .appData.value.secondColor),
                                              textAlign: TextAlign.center,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            AppTextStyle(
                                              name: '147',
                                              color: HexColor(AppController
                                                  .appData.value.secondColor),
                                              textAlign: TextAlign.center,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            AppTextStyle(
                                              name: 'ليرة',
                                              color: HexColor(AppController
                                                  .appData.value.secondColor),
                                              textAlign: TextAlign.center,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 90.w,
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r)),
                                          color: HexColor(AppController
                                              .appData.value.primaryColor),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.r),
                                            child: AppTextStyle(
                                              name: 'قبول الطلب',
                                              color: Colors.white,
                                              textAlign: TextAlign.center,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: 90.w,
                                        child: Card(
                                          elevation: 4,
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
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                  itemCount: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
