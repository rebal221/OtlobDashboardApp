import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/services/preferences/app_preferences.dart';

class RestaurantModel {
  String uid = '';
  String emailAuthUid = '';
  String name = '';
  String categoryUid = '';
  String phone = '';
  String city = '';
  String email = '';
  String provider = 'email';
  String fcm = '';
  List<dynamic> images = <String>[];
  String restaurantRate = 'مستخدم جديد';
  List<dynamic> paymentTypes = <String>[];
  bool isActiveAccount = true;
  String password = '';
  CategoryModel category = CategoryModel();
  GeoPoint latLong = GeoPoint(
      double.parse(AppPreferences().getData(key: 'lat')),
      double.parse(AppPreferences().getData(key: 'long')));
  DateTime created = DateTime.now();
  DateTime lastSeen = DateTime.now();
  DateTime lastUpdate = DateTime.now();
  String workTimeFrom = '';
  String workTimeTo = '';
  String pricingFrom = '';
  String pricingTo = '';
  String restaurantAdderss = '';
  String deliveryPricing = '';
  String restaurantDescription = '';
  bool isCompleteData = false;
  bool isAdvanceReservation = false;
  double totalPay = 0.0;
  int countOrder = 0;

  RestaurantModel();

  RestaurantModel.createAccount(
      {required this.uid,
      required this.emailAuthUid,
      required this.email,
      required this.password});

  RestaurantModel.add({
    // required this.emailAuthUid,
    required this.name,
    required this.categoryUid,
    required this.phone,
    required this.category,
    // required this.phone,
    // required this.adderss,
    // required this.city,
    // required this.email,
    required this.isCompleteData,
    required this.isAdvanceReservation,
    required this.images,
    required this.paymentTypes,
    // required this.password,
    // required this.latLong,
    required this.workTimeFrom,
    required this.workTimeTo,
    required this.pricingFrom,
    required this.pricingTo,
    required this.restaurantAdderss,
    required this.deliveryPricing,
    required this.restaurantDescription,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = uid;
    map['emailAuthUid'] = emailAuthUid;
    map['name'] = name;
    map['phone'] = phone;
    // map['adderss'] = adderss;
    map['images'] = images;
    map['city'] = city;
    map['countOrder'] = countOrder;
    map['totalPay'] = totalPay;
    map['categoryUid'] = categoryUid;
    map['category'] = category.toMap();
    map['email'] = email;
    map['provider'] = provider;
    map['fcm'] = fcm;
    map['restaurantRate'] = restaurantRate;
    map['paymentTypes'] = paymentTypes;
    map['isActiveAccount'] = isActiveAccount;
    map['password'] = password;
    map['latLong'] = latLong;
    map['created'] = created;
    map['workTimeFrom'] = workTimeFrom;
    map['workTimeTo'] = workTimeTo;
    map['pricingFrom'] = pricingFrom;
    map['pricingTo'] = pricingTo;
    map['restaurantAdderss'] = restaurantAdderss;
    map['deliveryPricing'] = deliveryPricing;
    map['restaurantDescription'] = restaurantDescription;
    map['isCompleteData'] = isCompleteData;
    map['isAdvanceReservation'] = isAdvanceReservation;
    map['lastSeen'] = lastSeen;
    map['lastUpdate'] = lastUpdate;

    map['created'] = created;

    return map;
  }

  Map<String, dynamic> toMapCompleteData() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['uid'] = AppPreferences().getUserDataAsMap()['uid'];
    map['emailAuthUid'] = AppPreferences().getUserDataAsMap()['emailAuthUid'];
    map['name'] = name;
    map['phone'] = phone;
    map['countOrder'] = countOrder;
    map['totalPay'] = totalPay;
    // map['adderss'] = adderss;
    map['images'] = images;
    map['city'] = city;
    map['categoryUid'] = categoryUid;
    map['category'] = category.toMap();
    map['email'] = AppPreferences().getUserDataAsMap()['email'];
    map['provider'] = AppPreferences().getUserDataAsMap()['provider'];
    map['fcm'] = AppPreferences().getUserDataAsMap()['fcm'];
    map['restaurantRate'] = restaurantRate;
    map['paymentTypes'] = paymentTypes;
    map['isActiveAccount'] = isActiveAccount;
    map['password'] = AppPreferences().getUserDataAsMap()['password'];
    map['latLong'] = GeoPoint(
        double.parse(AppPreferences().getUserDataAsMap()['lat']),
        double.parse(AppPreferences().getUserDataAsMap()['long']));
    map['workTimeFrom'] = workTimeFrom;
    map['workTimeTo'] = workTimeTo;
    map['pricingFrom'] = pricingFrom;
    map['pricingTo'] = pricingTo;
    map['restaurantAdderss'] = restaurantAdderss;
    map['deliveryPricing'] = deliveryPricing;
    map['restaurantDescription'] = restaurantDescription;
    map['isCompleteData'] = isCompleteData;
    map['isAdvanceReservation'] = isAdvanceReservation;
    map['lastSeen'] = lastSeen;
    map['lastUpdate'] = lastUpdate;

    map['created'] =
        DateTime.parse(AppPreferences().getUserDataAsMap()['created']);

    return map;
  }

  RestaurantModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    countOrder = map['countOrder'];
    email = map['email'];
    phone = map['phone'];
    emailAuthUid = map['emailAuthUid'];
    totalPay = map['totalPay'];
    // adderss = map['adderss'];
    city = map['city'];
    provider = map['provider'];
    fcm = map['fcm'];
    images = map['images'];
    restaurantRate = map['restaurantRate'];
    paymentTypes = map['paymentTypes'];
    isActiveAccount = map['isActiveAccount'];
    password = map['password'];
    latLong = map['latLong'];
    categoryUid = map['categoryUid'];

    workTimeFrom = map['workTimeFrom'];
    workTimeTo = map['workTimeTo'];
    pricingFrom = map['pricingFrom'];
    pricingTo = map['pricingTo'];
    isCompleteData = map['isCompleteData'];
    restaurantAdderss = map['restaurantAdderss'];
    deliveryPricing = map['deliveryPricing'];
    isAdvanceReservation = map['isAdvanceReservation'];
    restaurantDescription = map['restaurantDescription'];

    category = CategoryModel.fromMapToSaveInLocal(map["category"]);
    created = map['created'].toDate();
    lastSeen = map['lastSeen'].toDate();
    lastUpdate = map['lastUpdate'].toDate();
  }

  Map<String, dynamic> toMapSaveData(RestaurantModel user) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['uid'] = user.uid.toString();
    map['emailAuthUid'] = user.emailAuthUid.toString();
    map['name'] = user.name.toString();
    map['phone'] = user.phone.toString();
    // map['adderss'] = user.adderss.toString();
    map['images'] = user.images.toString();
    map['city'] = user.city.toString();
    map['categoryUid'] = user.categoryUid.toString();
    map['email'] = user.email.toString();
    map['provider'] = user.provider.toString();
    map['fcm'] = user.fcm.toString();
    map['isAdvanceReservation'] = user.isAdvanceReservation;
    map['totalPay'] = user.totalPay;
    map['countOrder'] = user.countOrder;
    map['restaurantRate'] = user.restaurantRate.toString();
    map['paymentTypes'] = user.paymentTypes.toString();
    map['isActiveAccount'] = user.isActiveAccount;
    map['password'] = user.password.toString();
    map['category'] = user.category.toMapSaveLocal();
    map['lat'] = user.latLong.latitude.toString();
    map['long'] = user.latLong.longitude.toString();
    map['created'] = user.created.toString();
    map['lastSeen'] = user.lastSeen.toString();
    map['lastUpdate'] = user.lastUpdate.toString();
    map['isCompleteData'] = user.isCompleteData;
    map['workTimeFrom'] = user.workTimeFrom.toString();
    map['workTimeTo'] = user.workTimeTo.toString();
    map['pricingFrom'] = user.pricingFrom.toString();
    map['pricingTo'] = user.pricingTo.toString();
    map['restaurantAdderss'] = user.restaurantAdderss.toString();
    map['deliveryPricing'] = user.deliveryPricing.toString();
    map['restaurantDescription'] = user.restaurantDescription.toString();

    return map;
  }
}
