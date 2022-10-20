import 'package:get/get.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';

class ReadCategoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CategoryControllerReadData>(CategoryControllerReadData(),
        permanent: true);
  }
}
