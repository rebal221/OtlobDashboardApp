// ignore_for_file: must_be_immutable
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/drawer_pages/app_setting/ui/app_setting_body.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/drawer_pages/category/binding/category_binding.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/drawer_pages/category/ui/category_body.dart';
import 'package:otlab_controller/widget/drwaer_admin_widget.dart';

import '../drawer_pages/analysis/ui/analysis_body.dart';
import '../drawer_pages/home_controller_body/ui/home_controller_body.dart';
import '../drawer_pages/list_restaurant_body/ui/list_restaurant_body.dart';
import '../drawer_pages/tracking_order_body/ui/tracking_order_body.dart';

class MainAdminPage extends StatefulWidget {
  static int selectedIndex = AppPreferences().getDataInt(key: 'sa');

  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => MainAdminPageState();
}

class MainAdminPageState extends State<MainAdminPage> {
  static late StateSetter stateSetter;

  static bool isClickToOrderDetails = false;

  @override
  void initState() {
    // TODO: implement initState
    MainAdminPageState.stateSetter = setState;
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
    AppPreferences().setDataInt(key: 'sa', value: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MyBodyAdmin(
        selectedIndex: MainAdminPage.selectedIndex,
        myBody: myBody(context),
        setState: setState,
      );
    });
  }

  Widget myBody(BuildContext context) {
    return Builder(builder: (context) {
      return logicBody(context);
    });
  }

  Widget logicBody(BuildContext context) {
    if (MainAdminPage.selectedIndex == 0) {
      return HomeControllerBody(setState: setState);
    } else if (MainAdminPage.selectedIndex == 1) {
      return AppSettingBody(setState: setState);
    } else if (MainAdminPage.selectedIndex == 2) {
      CategoryBinding();
      return CategoryBody(setState: setState);
    } else if (MainAdminPage.selectedIndex == 3) {
      return ListRestaurantBody(setState: setState);
    } else if (MainAdminPage.selectedIndex == 4) {
      return TrackingOrderBody(setState: setState);
    } else if (MainAdminPage.selectedIndex == 5) {
      return AnalysisBody(setState: setState);
    }
    return const Card();
  }
}
