import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otlab_controller/value/colors.dart';
import 'package:otlab_controller/value/constant.dart';

showSuccessBar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: AppColors.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  ));
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

showErrorBar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: AppColors.secondaryColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    // margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
  ));
}

checklogin(
    TextEditingController testEmail, TextEditingController testPassword) {
  String res = '';
  if (!testEmail.text.isEmailValid()) {
    res += 'Email_Error';
  }
  if (!testPassword.text.isPasswordValid()) {
    res += 'Password_Error';
  }
  return res;
}

extension EmailValidation on String {
  bool isEmailValid() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PassWordValidation on String {
  bool isPasswordValid() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}

CutFireBaseError(String err) {
  String test;
  test = err.toString().split(' ').elementAt(0);
  if (test == '[firebase_auth/email-already-in-use]') {
    return 'البريد الإلكتروني المقدم قيد الاستخدام بالفعل من قبل مستخدم حالي';
  } else if (test == '[firebase_auth/user-not-found]') {
    return 'لا يوجد سجل مستخدم حالي مطابق للمعرف المقدم.';
  } else {
    return 'حدث خطأ ما يرجى المحاولة لاحقاً';
  }
}

bool checkconfirmpassword(String password, String confirmpassword) {
  if (password == confirmpassword) {
    return true;
  } else {
    return false;
  }
}

Future createrestaurant(
    {required String email,
    required String password,
    required User user}) async {
  final docUser =
      FirebaseFirestore.instance.collection('restaurant').doc(user.uid);

  final json = {
    'Name': 'name',
    'Email': email,
    'Password': password,
    'Img':
        'https://firebasestorage.googleapis.com/v0/b/otlobdriverapp-dd897.appspot.com/o/DriverApp_Images%2Fuser-96.png?alt=media&token=63e4912c-705e-4dc0-9348-19837460a071',
    'Phone': 'phone',
    'StreetNumber': 'street',
    'CityName': 'city',
  };

  docUser.set(json);
}

Future createMeal({
  required String restaurantID,
  required String mealName,
  required String mealDescription,
  required String mealType,
  required String mealPrice,
  required String imageOne,
  required String imageTow,
  required String imageThree,
}) async {
  if (!restaurantID.isEmpty &&
      !mealName.isEmpty &&
      !mealDescription.isEmpty &&
      !mealPrice.isEmpty &&
      mealType != '') {
    if (!imageOne.isEmpty && !imageTow.isEmpty && !imageThree.isEmpty) {
      final docMeal = FirebaseFirestore.instance.collection('meals');
      List<dynamic> images = [imageThree, imageTow, imageThree];
      final json = {
        'restaurantID': restaurantID,
        'mealName': mealName,
        'mealDescription': mealDescription,
        'mealType': mealType,
        'mealPrice': mealPrice,
        'mealImages': images,
        'mealCreatDate': DateTime.now().toString(),
        'mealID': getRandomString(15)
      };

      docMeal.add(json).then((value) {
        getSheetSucsses('تم إضافة الوجبة بنجاح');
      }).onError((error, stackTrace) {
        getSheetError(error.toString());
      });
    } else {
      getSheetError('يرجى ادخال صور الوجبة');
      return false;
    }
  } else {
    getSheetError('يرجى ادخال جميع البيانات');
    return false;
  }
}
