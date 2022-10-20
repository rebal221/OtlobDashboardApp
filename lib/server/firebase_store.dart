// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otlab_controller/pages/auth/auth_page/controller/auth_page_controller.dart';
import 'package:otlab_controller/server/controller/user_controller.dart';
import 'package:otlab_controller/server/model/app_model.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/services/preferences/app_preferences.dart';
import 'package:otlab_controller/utils/helpers.dart';
import 'package:otlab_controller/value/constant.dart';

import 'controller/app_controller.dart';
import 'model/admin_model.dart';
import 'model/restaurant_model.dart';

class FirebaseFirestoreController with Helpers {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ///app controller ///

  Stream<List<AppModel>> appDataList() {
    return _firebaseFirestore.collection("const").snapshots().map((snapshot) {
      log('appDataList streaming');
      return snapshot.docs.map((e) {
        AppController.getAppData(AppModel.appModelSnapshot(e));
        AppController.appData.value = AppModel.appModelSnapshot(e);

        return AppModel.appModelSnapshot(e);
      }).toList();
    });
  }

  ///Auth ///

  Future<Map<String, dynamic>?> getUserDataFromFirestore(
      {required String uid, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(uid)
        .get()
        .then((value) async {
      if (value.exists) {
        log('getUserDataFromFirestore in then done');
        if (collectionName == 'restaurant') {
          log('true');
          RestaurantModel restaurantModel =
              RestaurantModel.fromMap(value.data()!);
          UserController.restaurant.value = restaurantModel;
          Map<String, dynamic> data =
              restaurantModel.toMapSaveData(restaurantModel);
          log('data =>>\n $data');
          await AppPreferences().saveUserData(data);
          await AppPreferences().setDataBool(key: 'isAdmin', value: false);
          return value.data()!;
        } else {
          //ToDo: here to admin
          AdminModel adminModel = AdminModel.fromMap(value.data()!);
          UserController.admin.value = adminModel;
          Map<String, dynamic> data = adminModel.toMapSaveData(adminModel);
          log('data =>>\n $data');
          await AppPreferences().saveUserData(data);
          await AppPreferences().setDataBool(key: 'isAdmin', value: true);

          return value.data()!;
        }
      } else {
        log('false');

        return null;
      }
    }).catchError((onError) {
      AuthPageController.isLoading.value = false;

      log('ex getUserDataByUid ===>>>>> $onError');
      return null;
    });
  }

  Future<bool> checkUserExists(
      {required String uid, required String collectionName}) async {
    DocumentSnapshot snap =
        await _firebaseFirestore.collection(collectionName).doc(uid).get();
    if (snap.exists) {
      log("EXISTING USER");
      return true;
    } else {
      log("NEW USER");
      return false;
    }
  }

  Future<bool> addRestaurantToFirestore({
    required RestaurantModel restaurantModel,
  }) async {
    return await _firebaseFirestore
        .collection('restaurant')
        .doc(restaurantModel.uid)
        .set(restaurantModel.toMap())
        .then((value) {
      log('addRestaurantToFirestore done');
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> addAdminToFirestore({
    required AdminModel admin,
  }) async {
    return await _firebaseFirestore
        .collection('admin')
        .doc(admin.uid)
        .set(admin.toMap())
        .then((value) {
      log('addAdminToFirestore done');
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> updateRestaurantInFirestore(
      {required RestaurantModel restaurant, required String uid}) async {
    return await _firebaseFirestore
        .collection('restaurant')
        .doc(uid)
        .update(restaurant.toMapCompleteData())
        .then((value) async {
      return true;
    }).catchError((error) => false);
  }

  Future<bool> updateFirestore(
      {required String doc,
      required String key,
      required var value,
      bool isLoading = false,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(doc)
        .update({key: value}).then((value) {
      log('updateFirestore done');
      return true;
    }).catchError((error) {
      log('updateFirestore $error');
      getSheetSucsses(error.toString());
      isLoading = false;

      return false;
    });
  }

  Future<bool> updatePassword(
      {required String password,
      required uid,
      bool isLoading = false,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(uid)
        .update({"password": password}).then((value) {
      log('update password done');
      return true;
    }).catchError((onError) {
      getSheetError(onError.toString());
      log(onError.toString());
      isLoading = false;

      return false;
    });
  }

  /// start category ///
  Stream<List<CategoryModel>> categoryList() {
    return _firebaseFirestore
        .collection("category")
        .where('visible', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      log('categoryList streaming');
      return snapshot.docs.map((e) {
        return CategoryModel.categoryModelSnapshot(e);
      }).toList();
    });
  }

  Future<bool> addCategoryToFirestore(
      {required CategoryModel categoryModel}) async {
    return await _firebaseFirestore
        .collection('category')
        .add(categoryModel.toMap())
        .then((value) async {
      await updateFirestore(
          doc: value.id,
          key: 'uid',
          value: value.id,
          collectionName: 'category');
      log('addUserToFirestore done');
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> updateCategory(
      {required CategoryModel categoryModel, required String uid}) async {
    return await _firebaseFirestore
        .collection('category')
        .doc(uid)
        .update(categoryModel.toMapUpdate())
        .then((value) async {
      return true;
    }).catchError((error) => false);
  }

  /// end category ///
  /// delete quey
  Future<bool> deleteFromFirebase(
      {required String collectionName, required String uid}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(uid)
        .delete()
        .then((value) {
      log('deleteFromFirebase done');
      return true;
    }).catchError((value) {
      return false;
    });
  }
}
