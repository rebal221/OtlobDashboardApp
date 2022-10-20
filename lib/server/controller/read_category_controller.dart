import 'package:get/get.dart';
import 'package:otlab_controller/server/firebase_store.dart';
import 'package:otlab_controller/server/model/category_model.dart';

class CategoryControllerReadData extends GetxController {
  RxList<CategoryModel> listCategory = <CategoryModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getListCategory();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getListCategory();
    super.onReady();
  }

  Future<void> getListCategory() async {
    listCategory.bindStream(FirebaseFirestoreController().categoryList());
  }
}
