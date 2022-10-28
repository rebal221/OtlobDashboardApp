// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/extensions.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/widget/drop_down_serach_category.dart';
import 'package:otlab_controller/widget/list_food_widget.dart';
import 'package:otlab_controller/widget/row_icon.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../value/constant.dart';
import '../../../../../../widget/custom_image.dart';

class ListFoodBody extends StatefulWidget {
  StateSetter setState;

  ListFoodBody({super.key, required this.setState});
  @override
  State<ListFoodBody> createState() => _ListFoodBodyState();
}

class _ListFoodBodyState extends State<ListFoodBody> {
  final ScrollController controller = ScrollController();
  CategoryControllerReadData categorycontroller = Get.find();
  final _formKeyDropDownCategory = GlobalKey<FormState>();
  final TextEditingController mealName = TextEditingController();
  final TextEditingController mealDescription = TextEditingController();
  final TextEditingController mealPrice = TextEditingController();
  final TextEditingController editmealName = TextEditingController();
  final TextEditingController editmealDescription = TextEditingController();
  final TextEditingController editmealPrice = TextEditingController();
  TextEditingController ex1data = TextEditingController();
  TextEditingController ex2data = TextEditingController();
  TextEditingController ex3data = TextEditingController();
  TextEditingController ex1price = TextEditingController();
  TextEditingController ex2price = TextEditingController();
  TextEditingController ex3price = TextEditingController();
  bool ex1 = false;
  bool ex2 = false;
  bool ex3 = false;

  String? mealType;
  RxString imageOne = ''.obs;
  RxString imageTow = ''.obs;
  RxString imageThree = ''.obs;
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController3 =
      RoundedLoadingButtonController();

  // ignore: prefer_final_fields
  Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
      .collection('meals')
      .where("restaurantID", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  var sss = FirebaseFirestore.instance.collectionGroup('meals').get();

  getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('There is =====>>>> ${allData.length} Meals in your restaurant');
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
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
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
                    labelText: 'قائمة الطعام',
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
                        future: getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 10.h),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
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
                                                      ['mealImages'][0],
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
                                                  name: data[index]['mealName'],
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
                                                  name: data[index]
                                                      ['mealDescription'],
                                                  count: 2,
                                                  color: AppColors.greyE,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 23.sp,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Row(
                                                  children: [
                                                    RowIcon(
                                                      title: '' +
                                                          data[index]
                                                              ['mealPrice'] +
                                                          ' ليرة',
                                                      fontSize: 22.sp,
                                                      iconData:
                                                          Icons.monetization_on,
                                                      color: AppColors.greyE,
                                                    ),
                                                    SizedBox(
                                                      width: 26.w,
                                                    ),
                                                    RowIcon(
                                                      title: data[index]
                                                          ['mealType'],
                                                      fontSize: 26.sp,
                                                      iconData: Icons.list,
                                                      color: AppColors.greyE,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 260.w,
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const AppTextStyle(
                                                                      name:
                                                                          'تعديل الوجبة',
                                                                      color: AppColors
                                                                          .black,
                                                                    ),
                                                                    TextFieldAdd(
                                                                      width:
                                                                          400.w,
                                                                      tittle:
                                                                          'اسم الوجبة',
                                                                      hint: data[
                                                                              index]
                                                                          [
                                                                          'mealName'],
                                                                      height:
                                                                          100,
                                                                      heightSizeBox:
                                                                          140,
                                                                      controller:
                                                                          editmealName,
                                                                      type: TextInputType
                                                                          .text,
                                                                      enable:
                                                                          false,
                                                                    ),
                                                                    TextFieldAdd(
                                                                      width:
                                                                          400.w,
                                                                      tittle:
                                                                          'سعر الوجبة',
                                                                      hint: data[
                                                                              index]
                                                                          [
                                                                          'mealPrice'],
                                                                      height:
                                                                          100,
                                                                      heightSizeBox:
                                                                          140,
                                                                      controller:
                                                                          editmealPrice,
                                                                      type: TextInputType
                                                                          .text,
                                                                      enable:
                                                                          false,
                                                                    ),
                                                                    TextFieldAdd(
                                                                      width:
                                                                          400.w,
                                                                      tittle:
                                                                          'وصف الوجبة',
                                                                      hint: data[
                                                                              index]
                                                                          [
                                                                          'mealDescription'],
                                                                      height:
                                                                          100,
                                                                      heightSizeBox:
                                                                          140,
                                                                      controller:
                                                                          editmealDescription,
                                                                      type: TextInputType
                                                                          .text,
                                                                      enable:
                                                                          false,
                                                                    )
                                                                  ]),
                                                              actions: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                                  child:
                                                                      RoundedLoadingButton(
                                                                    color: HexColor(AppController
                                                                        .appData
                                                                        .value
                                                                        .primaryColor),
                                                                    successColor:
                                                                        AppColors
                                                                            .green,
                                                                    controller:
                                                                        _btnController2,
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'meals')
                                                                          .where(
                                                                              "mealID",
                                                                              isEqualTo: data[0]['mealID'])
                                                                          .get()
                                                                          .then((value) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('meals')
                                                                            .doc(value.docs[0].id)
                                                                            .update({
                                                                          'mealName':
                                                                              editmealName.text,
                                                                          'mealDescription':
                                                                              editmealDescription.text,
                                                                          'mealPrice':
                                                                              editmealPrice.text
                                                                        });
                                                                        _btnController2
                                                                            .success();
                                                                        editmealName.text =
                                                                            '';
                                                                        editmealDescription.text =
                                                                            '';
                                                                        editmealPrice.text =
                                                                            '';
                                                                      });

                                                                      // FirebaseFirestore
                                                                      //     .instance
                                                                      //     .collection(
                                                                      //         'meals')

                                                                      // launch("tel://" +
                                                                      //     phone +
                                                                      //     "");
                                                                    },
                                                                    valueColor:
                                                                        Colors
                                                                            .white,
                                                                    borderRadius:
                                                                        10,
                                                                    child: AppTextStyle(
                                                                        name:
                                                                            'تعديل'),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Card(
                                                          elevation: 4,
                                                          shape: RoundedRectangleBorder(
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
                                                                EdgeInsets.all(
                                                                    10.r),
                                                            child: AppTextStyle(
                                                              name: 'تعديل',
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'meals')
                                                              .where('mealID',
                                                                  isEqualTo: data[
                                                                          index]
                                                                      [
                                                                      'mealID'])
                                                              .get()
                                                              .then((value) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'meals')
                                                                .doc(value
                                                                    .docs[0].id)
                                                                .delete()
                                                                .then((value) {
                                                              getSheetSucsses(
                                                                  'تم خذف وجبة ' +
                                                                      data[index]
                                                                          [
                                                                          'mealName'] +
                                                                      '');
                                                            });
                                                          });
                                                        },
                                                        child: Card(
                                                          elevation: 4,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r)),
                                                          color: HexColor(
                                                              AppController
                                                                  .appData
                                                                  .value
                                                                  .secondColor),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.r),
                                                            child: AppTextStyle(
                                                              name: 'حذف',
                                                              color:
                                                                  Colors.white,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
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
              FadeInUp(
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                    labelText: 'اضافة وجبة جديدة',
                    labelStyle: GoogleFonts.cairo(
                        textStyle: TextStyle(
                      color: HexColor(AppController.appData.value.secondColor),
                      fontSize: 30.sp,
                    )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                  ),
                  child: SizedBox(
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
                              TextFieldAdd(
                                width: 400.w,
                                tittle: 'اسم الوجبة',
                                hint: 'أدخل اسم الوجبة',
                                height: 100,
                                heightSizeBox: 140,
                                controller: mealName,
                                type: TextInputType.text,
                                enable: false,
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
                                              name: ' تصنيف الوجبة',
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
                                                categoryModel:
                                                    CategoryModel.add(
                                                  uid: '',
                                                  name: 'مثال (بيتزا)',
                                                  image: '',
                                                  color: '',
                                                ),
                                                formKey:
                                                    _formKeyDropDownCategory,
                                                onSaved:
                                                    (CategoryModel? value) {},
                                                onChange: (CategoryModel?
                                                    value) async {
                                                  if (value != null) {
                                                    mealType = value.name;
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
                              TextFieldAdd(
                                width: 400.w,
                                tittle: 'سعر الوجبة',
                                hint: 'أدخل سعر الوجبة',
                                height: 100,
                                heightSizeBox: 140,
                                controller: mealPrice,
                                type: TextInputType.number,
                                enable: false,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  TextFieldAdd(
                                    width: 400.w,
                                    tittle: 'وصف الوجبة',
                                    hint: 'أدخل وصف الوجبة',
                                    height: 100,
                                    heightSizeBox: 140,
                                    controller: mealDescription,
                                    type: TextInputType.text,
                                    enable: false,
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  SizedBox(
                                    height: 210.h,
                                    width: 850.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppTextStyle(
                                          name: 'صور للوجبة',
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
                                              child: imageOne.value == ''
                                                  ? Card(
                                                      child: InkWell(
                                                      onTap: () {
                                                        uploadMealImage(1);
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
                                                        imageUrl:
                                                            imageOne.value,
                                                        boxFit:
                                                            BoxFitWeb.contain,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              height: 150.h,
                                              child: imageTow.value == ''
                                                  ? Card(
                                                      child: InkWell(
                                                      onTap: () {
                                                        uploadMealImage(2);
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
                                                        imageUrl:
                                                            imageTow.value,
                                                        boxFit:
                                                            BoxFitWeb.contain,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              height: 150.h,
                                              child: imageThree.value == ''
                                                  ? Card(
                                                      child: InkWell(
                                                      onTap: () {
                                                        uploadMealImage(3);
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
                                                        imageUrl:
                                                            imageThree.value,
                                                        boxFit:
                                                            BoxFitWeb.contain,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 60.w,
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
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            HexColor(AppController
                                                .hexColorPrimary.value)),
                                        value: ex1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ex1 = value!;
                                          });
                                        },
                                      ),
                                      TextFieldAdd(
                                        width: 200.w,
                                        tittle: 'الإضافة الأولى',
                                        hint: 'مثال: زيادة بطاطا',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex1data,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex1,
                                      ),
                                      SizedBox(width: 8),
                                      TextFieldAdd(
                                        width: 100.w,
                                        tittle: 'سعر الأضافة',
                                        hint: 'السعر',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex1price,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex1,
                                      ),
                                      SizedBox(width: 50.w)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            HexColor(AppController
                                                .hexColorPrimary.value)),
                                        value: ex2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ex2 = value!;
                                          });
                                        },
                                      ),
                                      TextFieldAdd(
                                        width: 200.w,
                                        tittle: 'الإضافة الثانية',
                                        hint: 'مثال: زيادة بطاطا',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex2data,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex2,
                                      ),
                                      SizedBox(width: 8),
                                      TextFieldAdd(
                                        width: 100.w,
                                        tittle: 'سعر الأضافة',
                                        hint: 'السعر',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex2price,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex2,
                                      ),
                                      SizedBox(width: 50.w)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            HexColor(AppController
                                                .hexColorPrimary.value)),
                                        value: ex3,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ex3 = value!;
                                          });
                                        },
                                      ),
                                      TextFieldAdd(
                                        width: 200.w,
                                        tittle: 'الإضافة الثالثة',
                                        hint: 'مثال: زيادة بطاطا',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex3data,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex3,
                                      ),
                                      SizedBox(width: 8),
                                      TextFieldAdd(
                                        width: 100.w,
                                        tittle: 'سعر الأضافة',
                                        hint: 'السعر',
                                        height: 100,
                                        heightSizeBox: 140,
                                        controller: ex3price,
                                        type: TextInputType.text,
                                        enable: false,
                                        enabledata: ex3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 95.w,
                                    height: 40.h,
                                    child: RoundedLoadingButton(
                                      color: HexColor(AppController
                                          .appData.value.primaryColor),
                                      successColor: AppColors.green,
                                      controller: _btnController3,
                                      onPressed: () {
                                        if (ex1 && ex2 && ex3) {
                                          if (ex1data.text.isNotEmpty &&
                                              ex1price.text.isNotEmpty &&
                                              ex2data.text.isNotEmpty &&
                                              ex2price.text.isNotEmpty &&
                                              ex3data.text.isNotEmpty &&
                                              ex3price.text.isNotEmpty) {
                                            createMeal(
                                                    restaurantID: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid,
                                                    mealName: mealName.text,
                                                    mealType:
                                                        mealType.toString(),
                                                    mealDescription:
                                                        mealDescription.text,
                                                    mealPrice: mealPrice.text,
                                                    imageOne: imageOne.value,
                                                    imageTow: imageTow.value,
                                                    imageThree:
                                                        imageThree.value,
                                                    ex1data: ex1data.text,
                                                    ex2data: ex2data.text,
                                                    ex3data: ex3data.text,
                                                    ex1price: ex1price.text,
                                                    ex2price: ex2price.text,
                                                    ex3price: ex3price.text)
                                                .then((value) {
                                              _btnController3.success();
                                            });
                                            Future.delayed(
                                                Duration(seconds: 1));
                                            _btnController3.reset();
                                          } else {
                                            getSheetError(
                                                'يرجى تعبئة الأضافات مع السعر');
                                            _btnController3.reset();
                                          }
                                        } else {
                                          getSheetError('يرجى تفعيل الأضافات');
                                          _btnController3.reset();
                                        }
                                      },
                                      valueColor: Colors.white,
                                      borderRadius: 10,
                                      child: AppTextStyle(name: 'اضافة وجبة'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width: 94.w,
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          clear();
                                        },
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
                                              name: 'إلغاء',
                                              color: Colors.white,
                                              textAlign: TextAlign.center,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  uploadMealImage(index) async {
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
        } else if (index == 2) {
          imageTow.value = urlFile;
        } else {
          imageThree.value = urlFile;
        }
        getSheetSucsses('نجحت العملية');
      }
    } else {
      getSheetError('فشلت العملية');
      debugPrint('result is null');
    }
  }

  void clear() {
    mealName.text = '';

    mealDescription.text = '';
    mealPrice.text = '';
    imageOne.value = '';
    imageTow.value = '';
    imageThree.value = '';
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
              // launch("tel://" + phone + "");
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
