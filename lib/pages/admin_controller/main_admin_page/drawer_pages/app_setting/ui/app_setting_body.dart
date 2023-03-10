// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/text_filed_edit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppSettingBody extends StatefulWidget {
  StateSetter setState;

  AppSettingBody({super.key, required this.setState});

  @override
  State<AppSettingBody> createState() => _AppSettingBodyState();
}

class _AppSettingBodyState extends State<AppSettingBody> {
  final ScrollController controller = ScrollController();
  final ScrollController controller1 = ScrollController();
  Color pickerColorPrimary = HexColor(AppController.appData.value.primaryColor);
  Color currentColorPrimary =
      HexColor(AppController.appData.value.primaryColor);

  Color pickerColorSecond = HexColor(AppController.appData.value.secondColor);
  Color currentColorSecond = HexColor(AppController.appData.value.secondColor);

  IconData iconEditName = Icons.edit;
  IconData iconEditPhone = Icons.edit;
  IconData iconEditPrivacy = Icons.edit;

  IconData iconEditGooglePlay = Icons.edit;
  IconData iconEditFacebook = Icons.edit;
  IconData iconEditTwitter = Icons.edit;
  IconData iconEditYoutube = Icons.edit;

  bool iconEditEnableName = false;
  bool iconEditEnablePrivacy = false;
  bool iconEditEnablePhone = false;
  bool iconEditEnableGooglePlay = false;
  bool iconEditEnableFacebook = false;
  bool iconEditEnableTwitter = false;
  bool iconEditEnableYoutube = false;
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  TextEditingController appName =
      TextEditingController(text: AppController.appData.value.appName);
  TextEditingController appPrivacy =
      TextEditingController(text: AppController.appData.value.appPrivacy);
  TextEditingController appPhone =
      TextEditingController(text: AppController.appData.value.appPhone);
  TextEditingController appOnGooglePlay =
      TextEditingController(text: AppController.appData.value.appOnGooglePlay);
  TextEditingController appFacebook =
      TextEditingController(text: AppController.appData.value.appFacebook);
  TextEditingController appTwitter =
      TextEditingController(text: AppController.appData.value.appTwitter);
  TextEditingController appYoutube =
      TextEditingController(text: AppController.appData.value.appYoutube);

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
                  labelText: '?????????????? ??????????????',
                  labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                    color: HexColor(AppController.appData.value.secondColor),
                    fontSize: 30.sp,
                  )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                child: SizedBox(
                    height: 1000.h,
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
                              height: 250.h,
                              width: 850.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: 180.w,
                                              height: 180.h,
                                              child: Card(
                                                child: Center(
                                                  child: CustomImageNetwork(
                                                    imageUrl: AppController
                                                        .appData.value.appLogo,
                                                    height: 120.h,
                                                    width: 120.w,
                                                  ),
                                                ),
                                              )),
                                          AppTextStyle(
                                            name: '?????????? ????????????',
                                            fontSize: 22.sp,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showAlertDialogPrimary();
                                            },
                                            child: SizedBox(
                                                width: 180.w,
                                                height: 180.h,
                                                child: Card(
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      radius: 50.r,
                                                      backgroundColor: HexColor(
                                                          AppController
                                                              .appData
                                                              .value
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          AppTextStyle(
                                            name: '?????????? ??????????????',
                                            fontSize: 22.sp,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showAlertDialogSecond();
                                            },
                                            child: SizedBox(
                                                width: 180.w,
                                                height: 180.h,
                                                child: Card(
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      radius: 50.r,
                                                      backgroundColor:
                                                          pickerColorSecond,
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          AppTextStyle(
                                            name: '?????????? ??????????????',
                                            fontSize: 22.sp,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '?????? ??????????????',
                                enable: iconEditEnableName,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditName,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnableName) {
                                          iconEditName = Icons.check;
                                        } else {
                                          iconEditName = Icons.edit;
                                        }

                                        iconEditEnableName =
                                            !iconEditEnableName;
                                      });
                                    }
                                  },
                                ),
                                hint: '?????? ??????????????',
                                controller: appName,
                                type: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '?????????? ??????????????',
                                enable: iconEditEnablePhone,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditPhone,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnablePhone) {
                                          iconEditName = Icons.check;
                                        } else {
                                          iconEditName = Icons.edit;
                                        }

                                        iconEditEnablePhone =
                                            !iconEditEnablePhone;
                                      });
                                    }
                                  },
                                ),
                                hint: '?????? ??????????????',
                                controller: appPhone,
                                type: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 1200.w,
                              height: 235.h,
                              child: TextFieldEdit(
                                heightSizeBox: 235,
                                widthSizeBox: 1200,
                                maxLines: 8,
                                height: 200,
                                width: 1200.w,
                                tittle: '?????????? ????????????????',
                                enable: iconEditEnablePrivacy,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditPrivacy,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnablePrivacy) {
                                          iconEditPrivacy = Icons.check;
                                        } else {
                                          iconEditPrivacy = Icons.edit;
                                        }

                                        iconEditEnablePrivacy =
                                            !iconEditEnablePrivacy;
                                      });
                                    }
                                  },
                                ),
                                hint: '?????????? ????????????????',
                                controller: appPrivacy,
                                type: TextInputType.multiline,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '???????? ?????????????? ???? ???????? ????????',
                                enable: iconEditEnableGooglePlay,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditGooglePlay,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnableGooglePlay) {
                                          iconEditGooglePlay = Icons.check;
                                          iconEditEnableGooglePlay =
                                              !iconEditEnableGooglePlay;
                                        } else {
                                          iconEditGooglePlay = Icons.edit;
                                          iconEditEnableGooglePlay =
                                              !iconEditEnableGooglePlay;
                                        }
                                      });
                                    }
                                  },
                                ),
                                hint: '???????? ?????????????? ???? ???????? ????????',
                                controller: appOnGooglePlay,
                                type: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '???????? ????????????',
                                enable: iconEditEnableFacebook,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditFacebook,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnableFacebook) {
                                          iconEditFacebook = Icons.check;
                                        } else {
                                          iconEditFacebook = Icons.edit;
                                        }

                                        iconEditEnableFacebook =
                                            !iconEditEnableFacebook;
                                      });
                                    }
                                  },
                                ),
                                hint: '???????? ????????????',
                                controller: appFacebook,
                                type: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '???????? ??????????',
                                enable: iconEditEnableTwitter,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditTwitter,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnableTwitter) {
                                          iconEditTwitter = Icons.check;
                                        } else {
                                          iconEditTwitter = Icons.edit;
                                        }

                                        iconEditEnableTwitter =
                                            !iconEditEnableTwitter;
                                      });
                                    }
                                  },
                                ),
                                hint: '???????? ??????????',
                                controller: appTwitter,
                                type: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            SizedBox(
                              width: 400.w,
                              child: TextFieldEdit(
                                width: 400.w,
                                tittle: '???????? ????????????',
                                enable: iconEditEnableYoutube,
                                suffix: IconButton(
                                  icon: Icon(
                                    iconEditYoutube,
                                    size: 22.r,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (mounted) {
                                      setState(() {
                                        if (iconEditEnableYoutube) {
                                          iconEditYoutube = Icons.check;
                                        } else {
                                          iconEditYoutube = Icons.edit;
                                        }

                                        iconEditEnableYoutube =
                                            !iconEditEnableYoutube;
                                      });
                                    }
                                  },
                                ),
                                hint: '???????? ????????????',
                                controller: appYoutube,
                                type: TextInputType.text,
                              ),
                            ),
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
                                      child: RoundedLoadingButton(
                                        color: HexColor(AppController
                                            .appData.value.primaryColor),
                                        successColor: AppColors.green,
                                        controller: _btnController2,
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('const')
                                              .doc('wtgxrWQvgMRYExe7s2tH')
                                              .update({
                                            'appName': appName.text,
                                            'appPhone': appPhone.text,
                                            'appPrivacy': appPrivacy.text,
                                            'appFacebook': appFacebook.text,
                                            'appOnGooglePlay':
                                                appOnGooglePlay.text,
                                            'appYoutube': appYoutube.text,
                                            'appTwitter': appTwitter.text,
                                          }).then((value) =>
                                                  _btnController2.success());
                                        },
                                        valueColor: Colors.white,
                                        borderRadius: 10,
                                        child: AppTextStyle(name: '??????????'),
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
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }

  void showAlertDialogPrimary() {
    showDialog(
        context: context,
        builder: (_) {
          void changeColor(Color color) {
            setState(() => pickerColorPrimary = color);
          }

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              title: const Text('???????????? ?????????? ??????????????'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColorPrimary,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                Builder(builder: (context) {
                  return AppButton(
                      color: pickerColorPrimary,
                      title: '???????? ?????????? ??????????????',
                      onPressed: () async {
                        setState(
                            () => currentColorPrimary = pickerColorPrimary);
                        String a = currentColorPrimary.toHex();
                        String finalColor = a.replaceRange(1, 3, '');
                        AppController.appData.value.primaryColor = finalColor;
                        //ToDo: here update function
                        bool status = await FirebaseFirestoreController()
                            .updateFirestore(
                                doc: 'wtgxrWQvgMRYExe7s2tH',
                                key: 'primaryColor',
                                value: finalColor,
                                collectionName: 'const');
                        log(status.toString());
                        Get.back();
                        log('finalColor is $finalColor');
                        // Navigator.of(context).pop();
                      });
                }),
              ],
            );
          });
        });
  }

  void showAlertDialogSecond() {
    showDialog(
        context: context,
        builder: (_) {
          void changeColor(Color color) {
            setState(() => pickerColorSecond = color);
          }

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              title: const Text('???????????? ?????????? ????????????'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColorSecond,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                Builder(builder: (context) {
                  return AppButton(
                      color: pickerColorPrimary,
                      title: '???????? ?????????? ??????????????',
                      onPressed: () async {
                        setState(() => currentColorSecond = pickerColorSecond);
                        String a = currentColorSecond.toHex();
                        String finalColor = a.replaceRange(1, 3, '');
                        AppController.appData.value.secondColor = finalColor;
                        //ToDo: here update function
                        bool status = await FirebaseFirestoreController()
                            .updateFirestore(
                                doc: 'wtgxrWQvgMRYExe7s2tH',
                                key: 'secondColor',
                                value: finalColor,
                                collectionName: 'const');
                        log(status.toString());
                        Get.back();
                        log('finalColor is $finalColor');
                        // Navigator.of(context).pop();
                      });
                }),
              ],
            );
          });
        });
  }
}
