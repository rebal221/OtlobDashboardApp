import 'package:get/get.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/controller/restaurant_settings_controller.dart';

class RestaurantSettingsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RestaurantSettingsController());
  }
}
