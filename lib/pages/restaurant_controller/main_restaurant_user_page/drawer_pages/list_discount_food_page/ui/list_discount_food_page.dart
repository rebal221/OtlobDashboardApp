// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/extensions.dart';
import 'package:otlab_controller/models_widgets/food_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';
import 'package:otlab_controller/value/constant.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/row_icon.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ListFoodDiscountPage extends StatefulWidget {
  StateSetter setState;

  ListFoodDiscountPage({super.key, required this.setState});

  @override
  State<ListFoodDiscountPage> createState() => _ListFoodDiscountPageState();
}

class _ListFoodDiscountPageState extends State<ListFoodDiscountPage> {
  final ScrollController controller = ScrollController();
  final TextEditingController discountValue = TextEditingController();
  final TextEditingController discountType = TextEditingController();
  RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController _btnController3 =
      RoundedLoadingButtonController();
  RxString imageOne = ''.obs;
  final _formKeyDropDownFood = GlobalKey<FormState>();
  RestaurantSettingsController _controller = Get.find();

  List<String> items = <String>[];
  var formKey = GlobalKey<FormState>();
  String? selectedValue;
  FoodWidgetModel food = FoodWidgetModel('اختر الوجبة التي عليها خصم');

  FoodWidgetModel foodSelected = FoodWidgetModel('اختر الوجبة التي عليها خصم');

  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    super.initState();
  }

  Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
      .collection('meals')
      .where("restaurantID", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('There is =====>>>> ${allData.length} Meals in your restaurant');
    return allData;
  }

  Query<Map<String, dynamic>> _Offers = FirebaseFirestore.instance
      .collection('offers')
      .where("restaurantID", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  getoffers() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _Offers.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('There is =====>>>> ${allData.length} Offers in your restaurant');
    return allData;
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
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
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'قائمة الخصومات',
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
                child: FutureBuilder(
                    future: getoffers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var data = snapshot.data as List;
                        return GridView.builder(
                          controller: controller,
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
                                              imageUrl: data[index]
                                                  ['offerImage'],
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
                                              name: data[index]['offerName'],
                                              count: 2,
                                              color: AppColors.greyE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.sp,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            AppTextStyle(
                                              name: data[index]['offerType'],
                                              count: 2,
                                              color: AppColors.greyE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26.sp,
                                              maxLines: 2,
                                            ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Row(
                                              children: [
                                                RowIcon(
                                                  title: data[index]
                                                      ['offerValue'],
                                                  fontSize: 28.sp,
                                                  iconData:
                                                      Icons.monetization_on,
                                                  color: AppColors.greyE,
                                                ),
                                                SizedBox(
                                                  width: 26.w,
                                                ),
                                                RowIcon(
                                                  title: data[index]
                                                      ['offerCreatDate'],
                                                  fontSize: 28.sp,
                                                  iconData: Icons.date_range,
                                                  color: AppColors.greyE,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 160.w,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              SizedBox(
                                                width: 70.w,
                                                child: RoundedLoadingButton(
                                                  color: HexColor(AppController
                                                      .appData
                                                      .value
                                                      .secondColor),
                                                  successColor: AppColors.green,
                                                  controller: _btnController3,
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('offers')
                                                        .where('offerId',
                                                            isEqualTo:
                                                                data[index]
                                                                    ['offerId'])
                                                        .get()
                                                        .then((value) {
                                                      FirebaseFirestore.instance
                                                          .collection('offers')
                                                          .doc(value.docs[0].id)
                                                          .delete()
                                                          .then((value) =>
                                                              _btnController3
                                                                  .success());
                                                    });
                                                  },
                                                  valueColor: Colors.white,
                                                  borderRadius: 10,
                                                  child:
                                                      AppTextStyle(name: 'حذف'),
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
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'اضافة خصم جديدة',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  String x = '';
                  var data = snapshot.data as List;
                  List<String> s = <String>[];
                  for (var i = 0; i < data.length; i++) {
                    s += [data[i]['mealName']];
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                        height: 300.h,
                        width: 1600.w,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 400.w,
                                  child: TextFieldAdd(
                                    width: 400.w,
                                    tittle: 'نوع الخصم',
                                    hint: 'مثال (خصم مادي او توصيل مجاني)',
                                    height: 100,
                                    heightSizeBox: 140,
                                    controller: discountType,
                                    type: TextInputType.text,
                                    enable: false,
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                SizedBox(
                                  width: 400.w,
                                  child: TextFieldAdd(
                                    width: 400.w,
                                    tittle: 'قيمة الخصم',
                                    hint: 'ادخل هيمة الخصم ',
                                    height: 100,
                                    heightSizeBox: 140,
                                    controller: discountValue,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                name: 'اسم الوجبة',
                                                fontSize: 22.sp,
                                                color: Colors.grey.shade800,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    'اختر الوجبة',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  items: s
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value:
                                                                item.toString(),
                                                            child: Text(
                                                              item.toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: selectedValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedValue =
                                                          value as String;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                  buttonHeight: 40,
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  buttonElevation: 2,
                                                  itemHeight: 40,
                                                  itemPadding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                  dropdownMaxHeight: 200,
                                                  dropdownWidth: 300,
                                                  dropdownPadding: null,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                  dropdownElevation: 8,
                                                  scrollbarRadius:
                                                      Radius.circular(40),
                                                  scrollbarThickness: 4,
                                                  scrollbarAlwaysShow: true,
                                                  offset: Offset(-20, 0),
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
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  height: 100.h,
                                  child: imageOne.value == ''
                                      ? Card(
                                          child: InkWell(
                                          onTap: () {
                                            uploadOfferImage(1);
                                          },
                                          child: Center(
                                            child: Icon(
                                                Icons
                                                    .photo_size_select_actual_rounded,
                                                color: Colors.black,
                                                size: 75.r),
                                          ),
                                        ))
                                      : InkWell(
                                          onTap: () {},
                                          child: CustomImageNetwork(
                                            width: 150.w,
                                            height: 150.h,
                                            imageUrl: imageOne.value,
                                            boxFit: BoxFitWeb.contain,
                                          ),
                                        ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 70.h,
                                          width: 140.w,
                                          child: RoundedLoadingButton(
                                            color: HexColor(AppController
                                                .appData.value.primaryColor),
                                            successColor: AppColors.green,
                                            controller: _btnController2,
                                            onPressed: () {
                                              // createOffer();
                                              if (imageOne.toString() != '') {
                                                if (discountType
                                                        .text.isNotEmpty &&
                                                    discountValue
                                                        .text.isNotEmpty &&
                                                    selectedValue!.isNotEmpty) {
                                                  FirebaseFirestore.instance
                                                      .collection('meals')
                                                      .where('restaurantID',
                                                          isEqualTo:
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                      .get()
                                                      .then((value) {
                                                    for (var i = 0;
                                                        i < value.docs.length;
                                                        i++) {
                                                      if (value.docs[i]
                                                              ['mealName'] ==
                                                          selectedValue) {
                                                        createOffer(
                                                                restaurantName:
                                                                    _controller
                                                                        .nameRestaurant
                                                                        .text,
                                                                restaurantAddress:
                                                                    _controller
                                                                        .adderssRestaurant
                                                                        .text,
                                                                offerName:
                                                                    selectedValue
                                                                        .toString(),
                                                                offerType:
                                                                    discountType
                                                                        .text
                                                                        .toString(),
                                                                offerValue:
                                                                    discountValue
                                                                        .text
                                                                        .toString(),
                                                                mealID: value
                                                                    .docs[i].id,
                                                                image: imageOne
                                                                    .value)
                                                            .then((value) {
                                                          _btnController2
                                                              .success();
                                                        });
                                                      }
                                                    }
                                                    print(value.docs);
                                                  });
                                                } else {
                                                  getSheetError(
                                                      'يرجى ادخال جميع البيانات');
                                                  _btnController2.reset();
                                                }
                                              } else {
                                                getSheetError(
                                                    'يرجى اختيار صورة للعرض');
                                                _btnController2.reset();
                                              }
                                            },
                                            valueColor: Colors.white,
                                            borderRadius: 10,
                                            child:
                                                AppTextStyle(name: 'اضافة عرض'),
                                          ),
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
                        ));
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: SpinKitThreeBounce(
                        color:
                            HexColor(AppController.appData.value.secondColor),
                        size: 50.0,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadOfferImage(index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      getSheetSucsses('جاري تنفيذ العملية');
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName = result.files.first.name;
      String pathFile = fileName;
      TaskSnapshot uploadTaskSnapshot = await FirebaseStorage.instance
          .ref('uploads/$pathFile')
          .putData(fileBytes);
      String urlFile = await uploadTaskSnapshot.ref.getDownloadURL();
      debugPrint(' url is $urlFile');
      if (urlFile.isNotEmpty) {
        if (index == 1) {
          imageOne.value = urlFile;
        }
        getSheetSucsses('نجحت العملية');
      }
    } else {
      getSheetError('فشلت العملية');
      debugPrint('result is null');
    }
  }
}


  // DropdownButton(
  //                                                   value: x,
  //                                                   hint: const AppTextStyle(
  //                                                       name: 'اختر الوجبة',
  //                                                       color: Colors.black),
  //                                                   isExpanded: true,
  //                                                   style: Theme.of(context)
  //                                                       .textTheme
  //                                                       .headline6,
  //                                                   onChanged: (value) {
  //                                                     setState(() {
  //                                                       x = value!;
  //                                                     });
  //                                                   },
  //                                                   items:
  //                                                       s.map((String value) {
  //                                                     return DropdownMenuItem<
  //                                                         String>(
  //                                                       value: value,
  //                                                       child: AppTextStyle(
  //                                                           name: value,
  //                                                           color:
  //                                                               Colors.black),
  //                                                     );
  //                                                   }).toList(),
  //                                                 );



