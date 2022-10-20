import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otlab_controller/value/colors.dart';

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