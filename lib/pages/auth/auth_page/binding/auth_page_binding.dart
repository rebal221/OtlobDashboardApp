import 'package:get/get.dart';
import 'package:otlab_controller/pages/auth/auth_page/controller/auth_page_controller.dart';

class AuthPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthPageController());
  }
}
