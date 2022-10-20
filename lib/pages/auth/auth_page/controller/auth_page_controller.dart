// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/body_page/main_admin_page.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/binding/main_restaurant_binding.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/body_page/main_restaurant_user_page.dart';
import 'package:otlab_controller/server/firebase_auth.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/server/model/admin_model.dart';
import 'package:otlab_controller/server/model/restaurant_model.dart';
import 'package:otlab_controller/value/constant.dart';

import '../../../admin_controller/main_admin_page/body_page/binding/main_admin_page_binding.dart';

class AuthPageController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  static RxBool isLoading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    NetworkController().initConnectivity();

    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    NetworkController().initConnectivity();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    isLoading.value = false;
    NetworkController().initConnectivity();

    super.onClose();
  }

  bool checkDataLogin() {
    if (email.text.trim().isNotEmpty && password.text.trim().isNotEmpty) {
      if (EmailValidator.validate(email.text.trim())) {
        return true;
      }
      getSheetError('يرجى التاكد من صيغة البريد الاكتروني');

      return false;
    }

    getSheetError('يرجى تعبئة البيانات');
    return false;
  }

  bool checkDataCreateAccount() {
    if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty &&
        confirmPassword.text.trim().isNotEmpty) {
      if (EmailValidator.validate(email.text.trim())) {
        if (password.text == confirmPassword.text) {
          return true;
        }
        getSheetError('كلمة المرور غير متطابقة');
        return false;
      } else {
        getSheetError('يرجى التاكد من صيغة البريد الاكتروني');
        return false;
      }
    }

    getSheetError('يرجى تعبئة البيانات');
    return false;
  }

  bool checkDataForgetPassword() {
    if (email.text.trim().isNotEmpty) {
      if (EmailValidator.validate(email.text.trim())) {
        return true;
      }
      getSheetError('يرجى التاكد من صيغة البريد الاكتروني');

      return false;
    }

    getSheetError('يرجى تعبئة البيانات');
    return false;
  }

  Future<void> login(context) async {
    if (checkDataLogin()) {
      bool checkInternet = await NetworkController().initConnectivity();
      if (checkInternet) {
        isLoading.value = true;
        //ToDo: my login function
        bool status = await FirebaseAuthController()
            .signIn(context, email: email.text, password: password.text)
            .catchError((onError) {
          isLoading.value = false;
          getSheetError(onError.toString());
        });
        if (status) {
          String uid = FirebaseAuthController().user.uid;
          //ToDo: check account in firestore
          bool statusRestaurant = await FirebaseFirestoreController()
              .checkUserExists(uid: uid, collectionName: 'restaurant')
              .catchError((onError) {
            isLoading.value = false;
            getSheetError(onError.toString());
          });
          log('check in restaurant collection => $statusRestaurant');

          if (statusRestaurant) {
            //ToDo:get off all to restaurant controller and save in local storage;

            var data = await FirebaseFirestoreController()
                .getUserDataFromFirestore(
                    uid: uid, collectionName: 'restaurant');
            if (!data.isNull) {
              if (data!['isActiveAccount']) {
                if (data['isCompleteData']) {
                  AppPreferences().setDataInt(key: 's', value: 0);

                  Get.to(const MainRestaurantPage(),
                      curve: Curves.ease,
                      binding: MainRestaurantBinding(),
                      duration: const Duration(seconds: 1));
                } else {
                  AppPreferences().setDataInt(key: 's', value: 3);
                  Get.to(const MainRestaurantPage(),
                      curve: Curves.ease,
                      binding: MainRestaurantBinding(),
                      duration: const Duration(seconds: 1));
                }
              } else {
                isLoading.value = false;
                AppPreferences().logOutUser();

                getSheetError('الحساب معطل !');
              }
            }
          } else {
            bool statusAdmin = await FirebaseFirestoreController()
                .checkUserExists(
                    uid: FirebaseAuthController().user.uid,
                    collectionName: 'admin')
                .catchError((onError) {
              isLoading.value = false;
              getSheetError(onError.toString());
            });
            log('check in admin collection => $statusAdmin');
            if (statusAdmin) {
              //ToDo:get off all to admin controller and save in local storage;
              var data = await FirebaseFirestoreController()
                  .getUserDataFromFirestore(uid: uid, collectionName: 'admin');
              if (!data.isNull) {
                if (data!['isActive']) {
                  Get.to(const MainAdminPage(),
                      curve: Curves.ease,
                      binding: MainAdminPageBinding(),
                      duration: const Duration(seconds: 1));
                } else {
                  isLoading.value = false;
                  AppPreferences().logOutUser();

                  getSheetError('الحساب معطل !');
                }
              } else {
                isLoading.value = false;
                log('account not found');

                getSheetError('الحساب غير موجود !');
              }
            } else {
              isLoading.value = false;
              log('account not found');
              AppPreferences().logOutUser();

              getSheetError('الحساب غير موجود !');
            }
          }
        }
      } else {
        getSheetError('يرجى التحقق من اتصال الانترنت !');
      }
    }
  }

  Future<void> forgetPassword(context) async {
    if (checkDataForgetPassword()) {
      bool checkInternet = await NetworkController().initConnectivity();
      if (checkInternet) {
        isLoading.value = true;
        bool status = await FirebaseAuthController()
            .forgetPassword(context, email: email.text)
            .catchError((onError) {
          isLoading.value = false;
          getSheetError(onError.toString());
        });
        if (status) {
          getSheetSucsses(
              'تم ارسال ايميل عبر البريد الإكتروني لإسترجاع كلمة المرور');
        } else {
          getSheetError('يرجى المحاولة لاحقا !');
        }
      } else {
        getSheetError('يرجى التحقق من اتصال الانترنت !');
      }
    }
  }

  Future<void> createAccount(context) async {
    if (checkDataCreateAccount()) {
      bool checkInternet = await NetworkController().initConnectivity();
      if (checkInternet) {
        isLoading.value = true;
        User? user = await FirebaseAuthController()
            .createAccount(context, email: email.text, password: password.text)
            .catchError((onError) {
          isLoading.value = false;
          getSheetError(onError.toString());
        });
        if (user != null) {
          //ToDo here firestore function

          await FirebaseFirestoreController()
              .addRestaurantToFirestore(
                  restaurantModel: RestaurantModel.createAccount(
                      uid: user.uid,
                      emailAuthUid: user.uid,
                      email: email.text,
                      password: password.text))
              .catchError((onError) {
            isLoading.value = false;
            getSheetError(onError.toString());
          }).then((value) async {
            isLoading.value = false;
          });
        }
      } else {
        getSheetError('يرجى التحقق من اتصال الانترنت !');
      }
    }
  }

  Future<void> addAdmin(context) async {
    isLoading.value = true;
    User? user = await FirebaseAuthController()
        .createAccount(context,
            email: 'rebalaljrmani9@outlook.com', password: '123456')
        .catchError((onError) {
      isLoading.value = false;
      getSheetError(onError.toString());
    });
    if (user != null) {
      //ToDo here firestore function
      AdminModel admin = AdminModel.add(
          email: 'rebalaljrmani9@outlook.com',
          password: '123456',
          uid: user.uid);
      bool status = await FirebaseFirestoreController()
          .addAdminToFirestore(admin: admin)
          .catchError((onError) {
        isLoading.value = false;
        getSheetError(onError.toString());
      });
      if (status) {
        isLoading.value = false;
        getSheetSucsses('تمت العملية بنجاح');
      }
    }
  }
}
