import 'package:get/get.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';

import '../../../../server/controller/user_controller.dart';
import '../drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';

class MainRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<UserController>(UserController(), permanent: true);

    Get.put<CategoryControllerReadData>(CategoryControllerReadData(),
        permanent: true);
    Get.put<RestaurantSettingsController>(RestaurantSettingsController(),
        permanent: true);
  }
}
