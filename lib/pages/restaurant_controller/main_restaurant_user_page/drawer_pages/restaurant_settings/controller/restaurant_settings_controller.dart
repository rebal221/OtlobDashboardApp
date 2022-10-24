// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:otlab_controller/models_widgets/check_box_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/controller/user_controller.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/server/model/restaurant_model.dart';
import 'package:otlab_controller/value/constant.dart';

class RestaurantSettingsController extends GetxController {
  static RxBool isLoading = false.obs;
  RxBool isAdvanceReservation = false.obs;
  TextEditingController nameRestaurant = TextEditingController();
  TextEditingController adderssRestaurant = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController descriptionRestaurant = TextEditingController();
  TextEditingController pricingFrom = TextEditingController();
  TextEditingController pricingTow = TextEditingController();
  TextEditingController pricingDelivery = TextEditingController();
  Rx<CategoryModel> selectedCategory = CategoryModel.add(
    uid: '',
    name: 'مثال (بيتزا)',
    image: '',
    color: '',
  ).obs;
  RxList<dynamic> paymentTypes = <dynamic>[].obs;
  RxList<dynamic> images = <dynamic>[].obs;

  RxString imageOne = ''.obs;
  RxString imageTow = ''.obs;
  RxString imageThree = ''.obs;
  Rx<TimeOfDay> timeFrom = const TimeOfDay(hour: 8, minute: 30).obs;
  Rx<TimeOfDay> timeTo = const TimeOfDay(hour: 22, minute: 00).obs;
  RxString timeFromAsString = ''.obs;
  RxString timeToAsString = ''.obs;
  RxList<Rx<CheckBoxModel>> paymentMethodList = <Rx<CheckBoxModel>>[
    CheckBoxModel(imagePath: 'pay', tittle: 'Paypal').obs,
    // CheckBoxModel(imagePath: 'visa', tittle: 'VISA').obs,
    // CheckBoxModel(imagePath: 'master', tittle: 'Master').obs,
    // CheckBoxModel(imagePath: 'cash', tittle: 'Cash').obs,
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    nameRestaurant =
        TextEditingController(text: UserController.restaurant.value.name);
    adderssRestaurant = TextEditingController(
        text: UserController.restaurant.value.restaurantAdderss);
    descriptionRestaurant = TextEditingController(
        text: UserController.restaurant.value.restaurantDescription);
    pricingFrom = TextEditingController(
        text: UserController.restaurant.value.pricingFrom);
    pricingTow =
        TextEditingController(text: UserController.restaurant.value.pricingTo);
    pricingDelivery = TextEditingController(
        text: UserController.restaurant.value.deliveryPricing);
    number = TextEditingController(text: UserController.restaurant.value.phone);
    perform();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    nameRestaurant =
        TextEditingController(text: UserController.restaurant.value.name);
    adderssRestaurant = TextEditingController(
        text: UserController.restaurant.value.restaurantAdderss);
    descriptionRestaurant = TextEditingController(
        text: UserController.restaurant.value.restaurantDescription);
    pricingFrom = TextEditingController(
        text: UserController.restaurant.value.pricingFrom);
    pricingTow =
        TextEditingController(text: UserController.restaurant.value.pricingTo);
    pricingDelivery = TextEditingController(
        text: UserController.restaurant.value.deliveryPricing);
    number = TextEditingController(text: UserController.restaurant.value.phone);
    perform();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameRestaurant.dispose();
    adderssRestaurant.dispose();
    descriptionRestaurant.dispose();
    pricingFrom.dispose();
    pricingTow.dispose();
    pricingDelivery.dispose();
    number.dispose();
    log('onClose');
    super.onClose();
  }

  bool checkData() {
    if (nameRestaurant.text.trim().isNotEmpty &&
        adderssRestaurant.text.trim().isNotEmpty &&
        number.text.trim().isNotEmpty &&
        descriptionRestaurant.text.trim().isNotEmpty &&
        pricingFrom.text.trim().isNotEmpty &&
        pricingTow.text.trim().isNotEmpty &&
        selectedCategory.value.uid.trim().isNotEmpty &&
        pricingDelivery.text.trim().isNotEmpty &&
        paymentTypes.value.isNotEmpty) {
      if (imageOne.value.isNotEmpty &&
          imageTow.value.isNotEmpty &&
          imageThree.value.isNotEmpty) {
        addImagesToList();
        return true;
      } else {
        getSheetError('يرجى اختيار 3 صور');
        return false;
      }
    }
    getSheetError('يرجى تعبئة البيانات');
    return false;
  }

  void uploadImage(index) async {
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

  void addImagesToList() {
    images.value.clear();
    images.value.add(imageOne.value);
    images.value.add(imageTow.value);
    images.value.add(imageThree.value);
  }

  void clickToPickTime(context) async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: timeTo.value);
    if (newTime != null) {
      timeTo.value = newTime;
      initValueTime();
    }
  }

  void clickFromPickTime(context) async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: timeFrom.value);
    if (newTime != null) {
      timeFrom.value = newTime;
      initValueTime();
    }
  }

  void initValueTime() {
    timeFromAsString.value =
        '${timeFrom.value.minute.toString().padLeft(2, '0')} : ${timeFrom.value.hour.toString().padLeft(2, '0')}';
    timeToAsString.value =
        '${timeTo.value.minute.toString().padLeft(2, '0')} : ${timeTo.value.hour.toString().padLeft(2, '0')}';
  }

  void addToPaymentList(value) {
    log('add item');

    paymentTypes.value.add(value);
  }

  void removeToPaymentList(value) {
    log('remove item');
    paymentTypes.value.removeWhere(
      (element) => element == value,
    );
  }

  Future<void> completeAccountData() async {
    if (checkData()) {
      if (await NetworkController().initConnectivity()) {
        // to do save my data
        isLoading.value = true;

        bool status = await FirebaseFirestoreController()
            .updateRestaurantInFirestore(
                uid: AppPreferences().getUserDataAsMap()['uid'],
                restaurant: restaurantData)
            .catchError((onError) {
          isLoading.value = false;

          getSheetError(onError.toString());
        });
        if (status) {
          String uid = AppPreferences().getUserDataAsMap()['uid'];

          //ToDO: GET USER DATA FORM FIRESTORE IN SAVE IN LOCAL STORAGE ;
          await FirebaseFirestoreController()
              .getUserDataFromFirestore(uid: uid, collectionName: 'restaurant')
              .catchError((onError) {
            isLoading.value = false;
            getSheetError(onError.toString());
          });
          isLoading.value = false;
          getSheetSucsses('تمت العملية بنجاح');
        }
      }
    }
  }

  RestaurantModel get restaurantData {
    RestaurantModel data = RestaurantModel.add(
        phone: number.text,
        name: nameRestaurant.text,
        categoryUid: selectedCategory.value.uid,
        category: selectedCategory.value,
        images: images.value,
        isAdvanceReservation: isAdvanceReservation.value,
        paymentTypes: paymentTypes.value,
        workTimeFrom: timeFromAsString.value,
        workTimeTo: timeToAsString.value,
        pricingFrom: pricingFrom.text,
        pricingTo: pricingTow.text,
        restaurantAdderss: adderssRestaurant.text,
        isCompleteData: true,
        deliveryPricing: pricingDelivery.text,
        restaurantDescription: descriptionRestaurant.text);
    return data;
  }

  void updateSelectedValue(value, index, tittle) {
    log('updateSelectedValue $value');

    paymentMethodList.value[index].value.active = value;
    if (value) {
      addToPaymentList(tittle);
    } else {
      removeToPaymentList(tittle);
    }
    update();
  }

  void initSelectedCategory() {
    if (UserController.restaurant.value.category.uid.isNotEmpty) {
      selectedCategory.value = UserController.restaurant.value.category;
    }
  }

  void initSelectedPaymentTypes() {
    if (UserController.restaurant.value.paymentTypes.isNotEmpty) {
      paymentTypes.value = UserController.restaurant.value.paymentTypes;
      for (int i = 0;
          i < UserController.restaurant.value.paymentTypes.length;
          i++) {
        int index = paymentMethodList.value.indexWhere((element) =>
            element.value.tittle ==
            UserController.restaurant.value.paymentTypes[i]);
        if (index != -1) {
          paymentMethodList.value[index].value.active = true;
          log('here update to element $index}');
        }
      }
    }
  }

  void initImages() {
    images.value = UserController.restaurant.value.images;
    if (UserController.restaurant.value.images.isNotEmpty) {
      for (int i = 0; i <= UserController.restaurant.value.images.length; i++) {
        log('length images is =>${UserController.restaurant.value.images.length}');
        log('here index = $i => url image => ${UserController.restaurant.value.images[i]}');

        if (i == 0) {
          imageOne.value = UserController.restaurant.value.images[0];
          continue;
        } else if (i == 1) {
          imageTow.value = UserController.restaurant.value.images[1];
          continue;
        } else if (i == 2) {
          imageThree.value = UserController.restaurant.value.images[2];
          break;
        }
      }
    }
  }

  void initTime() {
    if (UserController.restaurant.value.workTimeFrom.isNotEmpty &&
        UserController.restaurant.value.workTimeTo.isNotEmpty) {
      timeFromAsString.value = UserController.restaurant.value.workTimeFrom;
      timeToAsString.value = UserController.restaurant.value.workTimeTo;
    }
  }

  void perform() {
    if (UserController.restaurant.value.isCompleteData) {
      isAdvanceReservation.value =
          UserController.restaurant.value.isActiveAccount;
      log('perform');
      initValueTime();
      initSelectedCategory();
      initSelectedPaymentTypes();
      initImages();
      initTime();
    }
  }
}
