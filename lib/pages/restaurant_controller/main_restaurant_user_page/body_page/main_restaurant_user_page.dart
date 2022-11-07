// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/controller_body/ui/controller_body.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/list_discount_food_page/ui/list_discount_food_page.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/list_food_page/ui/list_food_page.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/restaurant_settings/ui/restaurant_settings.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/drawer_pages/setting_payment/payment_setting.dart';

class MainRestaurantPage extends StatefulWidget {
  static int selectedIndex = AppPreferences().getDataInt(key: 's');

  const MainRestaurantPage({super.key});

  @override
  State<MainRestaurantPage> createState() => MainRestaurantPageState();
}

class MainRestaurantPageState extends State<MainRestaurantPage> {
  static late StateSetter stateSetter;

  static bool isClickToOrderDetails = false;
  AppController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    MainRestaurantPageState.stateSetter = setState;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AppPreferences().setDataInt(key: 's', value: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      MainRestaurantPage.selectedIndex;
      // debugPrint('ss');
    });
    return Builder(builder: (context) {
      return Obx(() {
        return MyBodyRestaurant(
          selectedIndex: MainRestaurantPage.selectedIndex,
          myBody: myBody(context),
          setState: setState,
        );
      });
    });
  }

  Widget myBody(BuildContext context) {
    log(AppController.appData.value.primaryColor.toString());
    return Builder(builder: (context) {
      return logicBody(context);
    });
  }

  Widget logicBody(BuildContext context) {
    if (MainRestaurantPage.selectedIndex == 0) {
      return ControllerRestaurantBody(setState: setState);
    } else if (MainRestaurantPage.selectedIndex == 1) {
      return ListFoodBody(
        setState: setState,
      );
    } else if (MainRestaurantPage.selectedIndex == 2) {
      return ListFoodDiscountPage(
        setState: setState,
      );
    } else if (MainRestaurantPage.selectedIndex == 3) {
      return RestaurantSettingsBody(
        setState: setState,
      );
    } else if (MainRestaurantPage.selectedIndex == 4) {
      return RestaurantSettingsPayment(
        setState: setState,
      );
    }
    return const Card();
  }
}
