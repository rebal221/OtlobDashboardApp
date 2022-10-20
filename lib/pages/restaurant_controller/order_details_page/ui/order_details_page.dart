// ignore_for_file: must_be_immutable

import 'package:otlab_controller/models_widgets/food_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/restaurant_controller/main_restaurant_user_page/body_page/main_restaurant_user_page.dart';

import 'widgets/deliverys_list_widget.dart';
import 'widgets/order_food_list_widget.dart';

class OrderDetailsBody extends StatefulWidget {
  StateSetter setState;

  OrderDetailsBody({super.key, required this.setState});

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    super.initState();
  }

  List<FoodWidgetModel> foods = <FoodWidgetModel>[
    FoodWidgetModel.info(
        name: 'سندوتشات شاورما حجم وسط', price: 12.0, count: 5),
    FoodWidgetModel.info(
        name: 'سندوتشات شاورما حجم كبير', price: 26.0, count: 2),
    FoodWidgetModel.info(name: 'بيبسي كولا', price: 6.0, count: 2),
    FoodWidgetModel.info(name: 'عصير مانجو فريش', price: 5.0, count: 1),
  ];

  double deliveryPrice = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Builder(builder: (context) {
      return MyBodyRestaurant(
        isFromOrderDetails: true,
        selectedIndex: MainRestaurantPage.selectedIndex,
        myBody: myBodyWidget(context),
        setState: setState,
      );
    });
  }

  Widget myBodyWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: ListView(
        shrinkWrap: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // controller: controller,
        children: [
          SizedBox(
            height: 50.h,
            width: 50.w,
          ),
          OrderFoodListWidget(foods: foods, deliveryPrice: deliveryPrice),
          SizedBox(
            height: 50.h,
            width: 50.w,
          ),
          DeliversListWidget(),
          SizedBox(
            height: 100.h,
            width: 50.w,
          ),
        ],
      ),
    );
  }
}
