import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/services/preferences/app_preferences.dart';

class MealModel {
  String restaurantID = '';
  String name = '';
  String description = '';
  String price = '';
  List<dynamic> images = <String>[];

  MealModel();

  MealModel.createAccount(
      {required this.restaurantID,
      required this.name,
      required this.description,
      required this.price});

  MealModel.add({
    // required this.restaurantID,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['restaurantID'] = restaurantID;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['images'] = images;

    return map;
  }

  Map<String, dynamic> toMapCompleteData() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = AppPreferences().getUserDataAsMap()['uid'];
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;

    return map;
  }

  MealModel.fromMap(Map<String, dynamic> map) {
    restaurantID = map['restaurantID'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
    images = map['images'];
  }

  Map<String, dynamic> toMapSaveData(MealModel user) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['restaurantID'] = user.restaurantID.toString();
    map['name'] = user.name.toString();
    map['description'] = user.description.toString();
    map['price'] = user.price.toString();

    return map;
  }
}
