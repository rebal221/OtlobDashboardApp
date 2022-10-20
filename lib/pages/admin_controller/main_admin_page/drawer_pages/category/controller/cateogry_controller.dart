import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/value/constant.dart';

class CategoryController extends GetxController {
  TextEditingController name = TextEditingController();
  RxString image = ''.obs;
  RxString color = AppController.appData.value.primaryColor.obs;
  static RxBool isLoading = false.obs;
  static RxBool isClickedUpdate = false.obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    name = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    name.dispose();
    super.onClose();
  }

  bool checkData() {
    if (name.text.trim().isNotEmpty && image.value.isNotEmpty) {
      return true;
    }
    getSheetError('يرجى تعبئة البيانات');
    return false;
  }

  Future<void> addCategory() async {
    log('isLoading.value 1 =>${isLoading.value}');
    if (checkData()) {
      if (await NetworkController().initConnectivity()) {
        //ToDo : update loading and working function;
        log('isLoading.value 2 =>${isLoading.value}');

        if (isLoading.value == false) {
          log('isLoading.value 3 =>${isLoading.value}');

          isLoading.value = true;
          bool status = await FirebaseFirestoreController()
              .addCategoryToFirestore(
            categoryModel: CategoryModel.add(
                uid: '',
                name: name.text,
                image: image.value,
                color: color.value),
          )
              .catchError((onError) {
            isLoading.value = false;
            getSheetError(onError.toString());
          });
          if (status) {
            isLoading.value = false;
            getSheetSucsses('تمت العملية بنجاح');
            clearData();
          }
        } else {
          log('isLoading.value 4 =>${isLoading.value}');

          getSheetError('جاري تنفيذ العملية يرجى الانتظار');
        }
      } else {
        isLoading.value = false;

        getSheetError('يرجى التحقق من اتصال الانترنت !');
      }
    }
  }

  void uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      getSheetSucsses('جاري تنفيذ العملية');
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName = result.files.first.name;
      String pathFile =
          fileName + DateTime.now().microsecondsSinceEpoch.toString();
      TaskSnapshot uploadTaskSnapshot = await FirebaseStorage.instance
          .ref('uploads/$pathFile')
          .putData(fileBytes);
      String urlFile = await uploadTaskSnapshot.ref.getDownloadURL();
      debugPrint(' url is $urlFile');
      if (urlFile.isNotEmpty) {
        image.value = urlFile;
        getSheetSucsses('نجحت العملية');
      }
    } else {
      getSheetError('فشلت العملية');
      debugPrint('result is null');
    }
  }

  void clearData() {
    name.text = '';
    image.value = '';
    color.value = AppController.appData.value.primaryColor;
    isLoading.value = false;
    isClickedUpdate.value = false;
  }

  Future<void> deleteCategory(uid) async {
    bool status = await FirebaseFirestoreController()
        .updateFirestore(
      collectionName: 'category',
      doc: uid,
      key: 'visible',
      value: false,
    )
        .catchError((onError) {
      isLoading.value = false;
      getSheetError(onError.toString());
    });
    if (status) {
      getSheetSucsses('تمت عملية الحذف بنجاح');
    }
  }

  void onClickUpdate(CategoryModel categoryModel) {
    selectedCategory.value = categoryModel;
    name.text = selectedCategory.value.name;
    image.value = selectedCategory.value.image;
    color.value = selectedCategory.value.color;
    isClickedUpdate.value = true;
  }

  Future<void> updateCategory() async {
    if (checkData()) {
      if (await NetworkController().initConnectivity()) {
        if (isLoading.value == false) {
          isLoading.value = true;

          bool status = await FirebaseFirestoreController()
              .updateCategory(
                  categoryModel: CategoryModel.update(
                      uid: selectedCategory.value.uid,
                      name: name.text,
                      image: image.value,
                      visible: true,
                      created: selectedCategory.value.created,
                      color: color.value),
                  uid: selectedCategory.value.uid)
              .catchError((onError) {
            isLoading.value = false;
            getSheetError(onError.toString());
          });
          if (status) {
            isLoading.value = false;
            getSheetSucsses('تمت العملية بنجاح');
            clearData();
          }
        } else {
          getSheetError('جاري تنفيذ العملية يرجى الانتظار');
        }
      } else {
        isLoading.value = false;

        getSheetError('يرجى التحقق من اتصال الانترنت !');
      }
    }
  }
}
