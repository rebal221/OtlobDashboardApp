// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/body_page/main_admin_page.dart';
import 'package:otlab_controller/pages/auth/auth_page/binding/auth_page_binding.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/body_page/main_restaurant_user_page.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/services/preferences/app_preferences.dart';
import 'package:otlab_controller/value/constant.dart';
import 'package:otlab_controller/widget/show_loading_card.dart';

import '../../server/controller/app_controller.dart';
import '../admin_controller/main_admin_page/body_page/binding/main_admin_page_binding.dart';
import '../auth/auth_page/auth_page.dart';
import '../restaurant_controller/main_restaurant_user_page/binding/main_restaurant_binding.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  AppController controller = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('start screen ====>>> build');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ShowcaseCard(
          child: Image.asset(cupertinoActivityIndicator, scale: 2),
        ),
      ),
    );
  }

  Future<void> getData() async {
    bool status = await controller.getAppInfoStart();
    Future.delayed(const Duration(seconds: 4), () async {
      log('status is $status');
      if (status) {
        if (AppPreferences().loggedIn) {
          if (AppPreferences().getDataBool(key: 'isAdmin')) {
            //ToDo:get is Active and check it for admin
            await FirebaseFirestoreController().getUserDataFromFirestore(
                uid: AppPreferences().getUserDataAsMap()['uid'],
                collectionName: 'admin');
            if (AppPreferences().getUserDataAsMap()['isActive']) {
              Get.to(const MainAdminPage(),
                  curve: Curves.ease,
                  binding: MainAdminPageBinding(),
                  duration: const Duration(seconds: 1));
            } else {
              AppPreferences().logOutUser();
              Get.offAll(const AuthPage(),
                  binding: AuthPageBinding(),
                  curve: Curves.easeIn,
                  fullscreenDialog: true);
              getSheetError('الحساب معطل !');
            }
          } else {
            await FirebaseFirestoreController().getUserDataFromFirestore(
                uid: AppPreferences().getUserDataAsMap()['uid'],
                collectionName: 'restaurant');
            if (AppPreferences().getUserDataAsMap()['isActiveAccount']) {
              Future.delayed(const Duration(seconds: 3), () {
                if (AppPreferences().getUserDataAsMap()['isCompleteData']) {
                  AppPreferences().setDataInt(key: 's', value: 0);
                } else {
                  AppPreferences().setDataInt(key: 's', value: 3);
                }
                Get.offAll(const MainRestaurantPage(),
                    binding: MainRestaurantBinding(),
                    curve: Curves.easeIn,
                    fullscreenDialog: true);
              });
            } else {
              Get.offAll(const AuthPage(),
                  binding: AuthPageBinding(),
                  curve: Curves.easeIn,
                  fullscreenDialog: true);
              getSheetError('الحساب معطل !');
              AppPreferences().logOutUser();
            }
          }
        } else {
          AppPreferences().logOutUser();

          Future.delayed(const Duration(seconds: 4), () {
            Get.offAll(const AuthPage(),
                binding: AuthPageBinding(),
                curve: Curves.easeIn,
                fullscreenDialog: true);
            // Get.offAll(const MainAdminPage(),
            //     binding: CategoryBinding(),
            //     curve: Curves.easeIn,
            //     fullscreenDialog: true);
          });
        }
      }
    });
  }
}
