// ignore_for_file: must_be_immutable
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/order_details_page/ui/order_details_page.dart';
import 'package:otlab_controller/widget/row_icon.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../widget/custom_image.dart';

class ListRestaurantBody extends StatefulWidget {
  StateSetter setState;

  ListRestaurantBody({super.key, required this.setState});

  @override
  State<ListRestaurantBody> createState() => _ListRestaurantBodyState();
}

class _ListRestaurantBodyState extends State<ListRestaurantBody> {
  final ScrollController controllerScroll = ScrollController();
  AppController controller = Get.find();
  final _auth = FirebaseAuth.instance;
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

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

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('restaurant');

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

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
                height: 900.h,
                width: 1600.w,
                child: FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data as List;
                        return GridView.builder(
                          controller: controllerScroll,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 169.w / 38.h,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        SizedBox.fromSize(
                                            size: Size.fromRadius(50),
                                            child: CustomImageNetwork(
                                              width: 150.w,
                                              height: 150.h,
                                              imageUrl: data[index]['images']
                                                  [0],
                                              boxFit: BoxFitWeb.contain,
                                            )),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            AppTextStyle(
                                              name: data[index]['name'],
                                              count: 2,
                                              color: AppColors.greyE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            AppTextStyle(
                                              name: data[index]
                                                  ['restaurantDescription'],
                                              count: 2,
                                              color: AppColors.greyE,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 18.h,
                                            ),
                                            Row(
                                              children: [
                                                RowIcon(
                                                  title: 'متوسط الأسعار  ' +
                                                      data[0]['pricingFrom'] +
                                                      ' - ' +
                                                      data[0]['pricingTo'] +
                                                      ' ليرة',
                                                  fontSize: 22.sp,
                                                  iconData:
                                                      Icons.monetization_on,
                                                  color: AppColors.greyE,
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                RowIcon(
                                                  title: 'يفتح من ' +
                                                      data[0]['workTimeFrom'] +
                                                      ' الى ' +
                                                      data[0]['workTimeTo'] +
                                                      '',
                                                  fontSize: 22.sp,
                                                  iconData:
                                                      Icons.access_time_rounded,
                                                  color: AppColors.greyE,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 32.w,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 140.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialogPhone(
                                                              data[index]
                                                                  ['name'],
                                                              data[index]
                                                                  ['phone']),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 4,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r)),
                                                    color: HexColor(
                                                        AppController
                                                            .appData
                                                            .value
                                                            .primaryColor),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                      child: AppTextStyle(
                                                        name: 'اتصال بالمطعم',
                                                        color: Colors.white,
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              SizedBox(
                                                width: 140.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialog(
                                                              data[index]
                                                                  ['name'],
                                                              data[0]['uid']),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 4,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r)),
                                                    color: HexColor(
                                                        AppController.appData
                                                            .value.secondColor),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                      child: AppTextStyle(
                                                        name: 'حذف',
                                                        color: Colors.white,
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
          SizedBox(
            height: 50.h,
            width: 50.w,
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(String name, String Id) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: AppTextStyle(
        name: 'هل انت متأكد من حذف مطعم ' + name + '',
        color: AppColors.black,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: RoundedLoadingButton(
            color: HexColor(AppController.appData.value.primaryColor),
            successColor: AppColors.green,
            controller: _btnController2,
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('restaurant')
                  .doc(Id)
                  .delete()
                  .then((value) => _btnController2.success())
                  .onError((error, stackTrace) => _btnController2.error());
            },
            valueColor: Colors.white,
            borderRadius: 10,
            child: AppTextStyle(name: 'حذف'),
          ),
        )
      ],
    );
  }

  Widget _buildPopupDialogPhone(String name, String phone) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: AppTextStyle(
        name: 'هل أنت متأكد من اجراء مكالمة مع مطعم ' + name + '',
        color: AppColors.black,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: RoundedLoadingButton(
            color: HexColor(AppController.appData.value.primaryColor),
            successColor: AppColors.green,
            controller: _btnController2,
            onPressed: () {
              launch("tel://" + phone + "");
            },
            valueColor: Colors.white,
            borderRadius: 10,
            child: AppTextStyle(name: 'اتصال'),
          ),
        )
      ],
    );
  }
}
