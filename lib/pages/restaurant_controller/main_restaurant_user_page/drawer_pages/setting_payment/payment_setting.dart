// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/value/constant.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/drop_down_serach_category.dart';
import 'package:otlab_controller/widget/product_count.dart';

class RestaurantSettingsPayment extends StatefulWidget {
  StateSetter setState;

  RestaurantSettingsPayment({super.key, required this.setState});

  @override
  State<RestaurantSettingsPayment> createState() =>
      _RestaurantSettingsPaymentState();
}

class _RestaurantSettingsPaymentState extends State<RestaurantSettingsPayment> {
  bool sandBox = false;
  bool info = false;
  TextEditingController clientID = TextEditingController();
  TextEditingController secretKey = TextEditingController();

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
                  labelText: 'اعدادات الدفع',
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
                        AppTextStyle(
                          name: 'ادمج PayPal للمدفوعات عبر الإنترنت',
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w200,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        AppTextStyle(
                          name:
                              'يعمل هذا التكامل على إعداد خيارات الدفع عبر الإنترنت باستخدام PayPal ، والتي تقدم خيارات الدفع ذات الصلة للمشترين.\nأكمل الخطوات في البدء ، للحصول على معلومات الحساب التالية من Developer Dashboard.',
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w200,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        AppTextStyle(
                          name:
                              'نصيحة: لاحظ حساب sandbox Business الذي يتوافق معه التطبيق. ستحتاج إلى معرف البريد الإلكتروني وكلمة المرور لهذا الحساب عند اختبار التكامل.',
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 40.w,
                        ),
                        FutureBuilder(
                          future: getSetting(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var data = snapshot.data as List;
                              if (data[0]['paymentSetting'] != null) {
                                sandBox = data[0]['paymentSetting']['sandBox'];
                                clientID.text =
                                    data[0]['paymentSetting']['clientID'];
                                secretKey.text =
                                    data[0]['paymentSetting']['secretKey'];
                                info = true;
                              }
                              return sandBoxcheckBox(
                                box: sandBox,
                                clientID: clientID,
                                secretKey: secretKey,
                                info: info,
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
                          },
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

class sandBoxcheckBox extends StatefulWidget {
  sandBoxcheckBox({
    Key? key,
    required this.box,
    required this.info,
    required this.clientID,
    required this.secretKey,
  }) : super(key: key);
  late bool box;
  late TextEditingController clientID;
  late TextEditingController secretKey;
  late bool info;

  @override
  State<sandBoxcheckBox> createState() => _sandBoxcheckBoxState();
}

Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
    .collection('restaurant')
    .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

getSetting() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  return allData;
}

class _sandBoxcheckBoxState extends State<sandBoxcheckBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !widget.info
            ? AppTextStyle(
                name:
                    'ملاحظة : يرجى اكمال الاعدادات حتى تتمكن من تلقي المدفوعات من العملاء',
                color: Colors.red,
                fontSize: 30.sp,
                fontWeight: FontWeight.w200,
                textAlign: TextAlign.right,
              )
            : Text(''),
        SizedBox(
          height: !widget.info ? 30.h : 0,
        ),
        Row(
          children: [
            SizedBox(
              width: 40.w,
            ),
            SizedBox(
              width: 100.w,
              child: CheckboxListTile(
                  selected: widget.box,
                  contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                  activeColor:
                      HexColor(AppController.appData.value.primaryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  checkColor: Colors.white,
                  value: widget.box,
                  onChanged: (value) {
                    widget.box = value!;
                    setState(() {});
                  },
                  title: const AppTextStyle(
                    name: 'SandBox',
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              width: 40.w,
            ),
            SizedBox(
              width: 750.w,
              child: TextFieldAdd(
                width: 750.w,
                tittle: 'Client ID',
                hint: 'أدخل Client ID',
                height: 120,
                heightSizeBox: 160,
                controller: widget.clientID,
                type: TextInputType.streetAddress,
                enable: false,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 40.w,
            ),
            SizedBox(
              width: 750.w,
              child: TextFieldAdd(
                width: 750.w,
                tittle: 'Secret Key',
                hint: 'أدخل Secret Key',
                height: 120,
                heightSizeBox: 160,
                controller: widget.secretKey,
                type: TextInputType.streetAddress,
                enable: false,
              ),
            ),
          ],
        ),
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
                  isLoading: RestaurantSettingsController.isLoading.value,
                  color: HexColor(AppController.appData.value.primaryColor),
                  title: 'حفظ الاعدادات',
                  onPressed: () async {
                    if (widget.clientID.text != '' ||
                        widget.secretKey.text != '') {
                      FirebaseFirestore.instance
                          .collection('restaurant')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'paymentSetting': {
                          'sandBox': widget.box,
                          'clientID': widget.clientID.text,
                          'secretKey': widget.secretKey.text
                        }
                      }, SetOptions(merge: true)).then((value) {
                        getSheetSucsses('تم حفظ الأعدادات');
                      });
                    } else {
                      getSheetError('يرجى تعبئة البيانات');
                    }
                  }),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
      ],
    );
  }
}
