import 'package:get/get.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/drawer_pages/category/controller/cateogry_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CategoryController>(CategoryController(), permanent: true);
  }
}
