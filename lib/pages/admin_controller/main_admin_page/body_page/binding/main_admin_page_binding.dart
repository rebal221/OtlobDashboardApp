import 'package:get/get.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/drawer_pages/category/controller/cateogry_controller.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';
import 'package:otlab_controller/server/controller/user_controller.dart';

class MainAdminPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<RestaurantSettingsController>(RestaurantSettingsController(),
        permanent: true);
    Get.put<CategoryControllerReadData>(CategoryControllerReadData(),
        permanent: true);
    Get.put<CategoryController>(CategoryController(), permanent: true);
  }
}
