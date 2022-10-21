// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/order_details_page/ui/order_details_page.dart';

import '../../../../../../widget/app_button.dart';
import '../../../../../../widget/custom_image.dart';

class AnalysisBody extends StatefulWidget {
  StateSetter setState;

  AnalysisBody({super.key, required this.setState});

  @override
  State<AnalysisBody> createState() => _AnalysisBodyState();
}

class _AnalysisBodyState extends State<AnalysisBody> {
  final ScrollController controller = ScrollController();
  final ScrollController controller1 = ScrollController();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('restaurant');
  CollectionReference _collectionRefderiver =
      FirebaseFirestore.instance.collection('drivers');

  _getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  _getDataDriver() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRefderiver.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myBodyWidget(context);
  }

  Widget myBodyWidget(context) {
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
                labelText: 'احصائيات المطاعم',
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
                width: 1600.w,
                child: FutureBuilder(
                    future: _getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data as List;
                        return GridView.builder(
                          controller: controller1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 100.w / 44.h,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 100.h,
                                width: 100.w,
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  margin: EdgeInsetsDirectional.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 2.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // padding: EdgeInsetsDirectional.zero,
                                      // scrollDirection: Axis.horizontal,
                                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                                      // // controller: controller2,
                                      // shrinkWrap: true,
                                      // physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 65.w,
                                                  height: 65.h,
                                                  child: SizedBox.fromSize(
                                                      size:
                                                          Size.fromRadius(65.r),
                                                      child: CustomImageNetwork(
                                                        width: 150.w,
                                                        height: 150.h,
                                                        imageUrl: data[index]
                                                            ['images'][0],
                                                        boxFit:
                                                            BoxFitWeb.contain,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                AppTextStyle(
                                                  name: data[index]['name'],
                                                  color: AppColors.black,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 80.w,
                                                          child: Card(
                                                            elevation: 4,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r)),
                                                            color:
                                                                AppColors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              child:
                                                                  AppTextStyle(
                                                                name:
                                                                    'تم توصيل',
                                                                color: Colors
                                                                    .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        AppTextStyle(
                                                          name: '' +
                                                              data[index][
                                                                      'countOrder']
                                                                  .toString() +
                                                              ' طلبية',
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 80.w,
                                                          child: Card(
                                                            elevation: 4,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r)),
                                                            color:
                                                                AppColors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              child:
                                                                  AppTextStyle(
                                                                name:
                                                                    'قيمة الطلبيات',
                                                                color: Colors
                                                                    .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        AppTextStyle(
                                                          name: '' +
                                                              data[index][
                                                                      'totalPay']
                                                                  .toString() +
                                                              ' ليرة',
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 120.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        color: HexColor(
                                                            AppController
                                                                .appData
                                                                .value
                                                                .primaryColor),
                                                        title: 'اتصال بالمطعم',
                                                        onPressed: () {}),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 120.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        title: 'طباعة التقرير',
                                                        onPressed: () {},
                                                        color: Colors
                                                            .grey.shade900),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 120.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        title: 'ارسال التقرير',
                                                        onPressed: () {},
                                                        color: Colors
                                                            .grey.shade900),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          itemCount: data.length,
                        );
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: SpinKitThreeBounce(
                            color: HexColor(
                                AppController.appData.value.secondColor),
                            size: 50.0,
                          ),
                        );
                      }
                    }),
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
                labelText: 'احصائيات المناديب',
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
                width: 1600.w,
                child: FutureBuilder(
                    future: _getDataDriver(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data as List;

                        print(data.length);
                        return GridView.builder(
                          controller: controller1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 100.w / 44.h,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 100.h,
                                width: 100.w,
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  margin: EdgeInsetsDirectional.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 2.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // padding: EdgeInsetsDirectional.zero,
                                      // scrollDirection: Axis.horizontal,
                                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                                      // // controller: controller2,
                                      // shrinkWrap: true,
                                      // physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 65.w,
                                                  height: 65.h,
                                                  child: SizedBox.fromSize(
                                                      size:
                                                          Size.fromRadius(65.r),
                                                      child: CustomImageNetwork(
                                                        width: 150.w,
                                                        height: 150.h,
                                                        imageUrl: data[index]
                                                            ['Img'],
                                                        boxFit:
                                                            BoxFitWeb.contain,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                AppTextStyle(
                                                  name: data[index]['Name'],
                                                  color: AppColors.black,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 80.w,
                                                          child: Card(
                                                            elevation: 4,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r)),
                                                            color:
                                                                AppColors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              child:
                                                                  AppTextStyle(
                                                                name:
                                                                    'قام بتوصيل',
                                                                color: Colors
                                                                    .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        AppTextStyle(
                                                          name: '' +
                                                              data[index][
                                                                      'OrderCount']
                                                                  .toString() +
                                                              ' طلبية',
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 80.w,
                                                          child: Card(
                                                            elevation: 4,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r)),
                                                            color:
                                                                AppColors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              child:
                                                                  AppTextStyle(
                                                                name:
                                                                    'اجمالي القيمة',
                                                                color: Colors
                                                                    .black,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        AppTextStyle(
                                                          name: '' +
                                                              data[index][
                                                                      'TotalPay']
                                                                  .toString() +
                                                              ' ليرة',
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 160.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        color: HexColor(
                                                            AppController
                                                                .appData
                                                                .value
                                                                .primaryColor),
                                                        title: 'اتصال بالساق',
                                                        onPressed: () {}),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 160.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        title:
                                                            'تتبع على الخريطة',
                                                        onPressed: () {},
                                                        color: Colors
                                                            .grey.shade900),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 160.w,
                                                    height: 40.h,
                                                    child: AppButton(
                                                        title: 'طباعة التقرير',
                                                        onPressed: () {},
                                                        color: Colors
                                                            .grey.shade900),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          itemCount: data.length,
                        );
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: SpinKitThreeBounce(
                            color: HexColor(
                                AppController.appData.value.secondColor),
                            size: 50.0,
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
