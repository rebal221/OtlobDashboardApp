import 'dart:developer';

import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/server/model/meal_model.dart';
import 'package:otlab_controller/server/model/restaurant_model.dart';

import '../model/admin_model.dart';

class UserController extends GetxController {
  static final Rx<RestaurantModel> restaurant = RestaurantModel().obs;
  static final Rx<MealModel> meal = MealModel().obs;
  static final Rx<AdminModel> admin = AdminModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUserData();
    super.onInit();
  }

  void clear() {
    restaurant.value = RestaurantModel();
  }

  Future<void> getCurrentUserData() async {
    if (AppPreferences().loggedIn) {
      if (AppPreferences().getDataBool(key: 'isAdmin')) {
        await FirebaseFirestoreController().getUserDataFromFirestore(
            uid: AppPreferences().getUserDataAsMap()['uid'],
            collectionName: 'admin');
        log('isCompleteData ? =>${restaurant.value.isCompleteData}');
      } else {
        log('getCurrentUserData');
        await FirebaseFirestoreController().getUserDataFromFirestore(
            uid: AppPreferences().getUserDataAsMap()['uid'],
            collectionName: 'restaurant');
        log('isCompleteData ? =>${restaurant.value.isCompleteData}');
      }
    }
  }
}
