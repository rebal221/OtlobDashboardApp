// ignore_for_file: must_be_immutable
import 'package:flutter_animator/flutter_animator.dart';
import 'package:otlab_controller/models_widgets/food_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/drop_down_serach_food.dart';
import 'package:otlab_controller/widget/list_food_widget.dart';

class ListFoodDiscountPage extends StatefulWidget {
  StateSetter setState;

  ListFoodDiscountPage({super.key, required this.setState});

  @override
  State<ListFoodDiscountPage> createState() => _ListFoodDiscountPageState();
}

class _ListFoodDiscountPageState extends State<ListFoodDiscountPage> {
  final ScrollController controller = ScrollController();

  final _formKeyDropDownFood = GlobalKey<FormState>();

  FoodWidgetModel food = FoodWidgetModel('اختر الوجبة التي عليها خصم');

  FoodWidgetModel foodSelected = FoodWidgetModel('اختر الوجبة التي عليها خصم');

  List<FoodWidgetModel> items = <FoodWidgetModel>[
    FoodWidgetModel('name1'),
    FoodWidgetModel('name2'),
    FoodWidgetModel('name3'),
    FoodWidgetModel('name4'),
    FoodWidgetModel('name5'),
  ];
  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
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
  Widget build(BuildContext context) {
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
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'قائمة الخصومات',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                height: 450.h,
                width: 1600.w,
                child: GridView.builder(
                  controller: controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 169.w / 38.h,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (context, index) {
                    return const ListFoodWidget();
                  },
                  itemCount: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
            width: 50.w,
          ),
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'اضافة خصم جديدة',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                  height: 300.h,
                  width: 1600.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 400.w,
                            child: TextFieldAdd(
                              width: 400.w,
                              tittle: 'أدخل نوع الخصم',
                              hint: 'مثال (خصم مادي أو توصيل مجاني)',
                              controller: TextEditingController(),
                              type: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          SizedBox(
                            width: 400.w,
                            child: TextFieldAdd(
                              width: 400.w,
                              tittle: 'قيمة الخصم',
                              hint: 'أدخل قيمة الخصم',
                              controller: TextEditingController(),
                              type: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          SizedBox(
                            height: 140.h,
                            width: 400.w,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 140.h,
                                    width: 400.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppTextStyle(
                                          name: 'اسم الوجبة',
                                          fontSize: 22.sp,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 70.h,
                                          child: DropDownSearchFood(
                                              formKey: _formKeyDropDownFood,
                                              items: items,
                                              onSaved:
                                                  (FoodWidgetModel? value) {},
                                              onChange: (FoodWidgetModel?
                                                  value) async {
                                                if (value != null) {
                                                  widget.setState(() {
                                                    // appGet.categoryArray.clear();
                                                    foodSelected = value;
                                                    food = value;
                                                    foodSelected.name =
                                                        value.name;
                                                    debugPrint(
                                                        'new value food is ${food.name}');
                                                  });
                                                }
                                              },
                                              foodModel: food),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 70.h,
                                    width: 140.w,
                                    child: AppButton(
                                        color: HexColor(AppController
                                            .appData.value.primaryColor),
                                        title: 'اضافة الخصم',
                                        onPressed: () {}),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                    width: 140.w,
                                    child: AppButton(
                                        title: 'الغاء',
                                        onPressed: () {},
                                        color: Colors.grey.shade800),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
