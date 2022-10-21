// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_network/image_network.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/widget/row_icon.dart';

import '../../../../../../widget/app_button.dart';
import '../../../../../../widget/custom_image.dart';

class TrackingOrderBody extends StatefulWidget {
  StateSetter setState;

  TrackingOrderBody({super.key, required this.setState});

  @override
  State<TrackingOrderBody> createState() => _TrackingOrderBodyState();
}

class _TrackingOrderBodyState extends State<TrackingOrderBody> {
  final ScrollController controller = ScrollController();
  final ScrollController controller1 = ScrollController();

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

  CollectionReference _collectionRefderiver =
      FirebaseFirestore.instance.collection('drivers');
  _getDataDriver() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRefderiver.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
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
                labelText: 'قائمة المناديب',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                height: 900.h,
                width: 1600.w,
                child: FutureBuilder(
                    future: _getDataDriver(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data as List;
                        return GridView.builder(
                          controller: controller,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 169.w / 42.h,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 150.h,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // scrollDirection: Axis.horizontal,
                                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                                      // // controller: controller2,
                                      // shrinkWrap: true,
                                      // physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox.fromSize(
                                                size: const Size.fromRadius(50),
                                                child: CustomImageNetwork(
                                                  width: 150.w,
                                                  height: 150.h,
                                                  imageUrl: data[index]['Img'],
                                                  boxFit: BoxFitWeb.contain,
                                                )),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                AppTextStyle(
                                                  name: data[index]['Name'],
                                                  count: 2,
                                                  color: AppColors.greyE,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 120.w,
                                                      child: Card(
                                                        elevation: 4,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.r)),
                                                        color: AppColors.grey,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.r),
                                                          child: AppTextStyle(
                                                            name: 'مركبة نوع ' +
                                                                data[index][
                                                                    'CarType'] +
                                                                '',
                                                            color: Colors.black,
                                                            textAlign: TextAlign
                                                                .center,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SizedBox(
                                                      width: 120.w,
                                                      child: Card(
                                                        elevation: 4,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.r)),
                                                        color: AppColors.grey,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.r),
                                                          child: AppTextStyle(
                                                            name:
                                                                'يبعد 0.3 كلم',
                                                            color: Colors.black,
                                                            textAlign: TextAlign
                                                                .center,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 25.w,
                                                    ),
                                                    RowIcon(
                                                        title: 'حذف السائق',
                                                        fontColor: Colors.red,
                                                        fontSize: 16,
                                                        iconData: Icons
                                                            .delete_outline_outlined,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 150.w,
                                                height: 50.h,
                                                child: AppButton(
                                                    color: HexColor(
                                                        AppController
                                                            .appData
                                                            .value
                                                            .primaryColor),
                                                    title: 'تتبع على الخريطة',
                                                    onPressed: () {
                                                      MapsLauncher
                                                          .launchCoordinates(
                                                              37.4220041,
                                                              -122.0862462,
                                                              'Google Headquarters are here');
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              SizedBox(
                                                width: 150.w,
                                                height: 50.h,
                                                child: AppButton(
                                                    title: 'اتصال السائق',
                                                    onPressed: () {},
                                                    color:
                                                        Colors.grey.shade900),
                                              ),
                                            ],
                                          ),
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
