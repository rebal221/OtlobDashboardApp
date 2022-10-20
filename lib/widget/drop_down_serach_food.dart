// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:otlab_controller/models_widgets/food_model.dart';
import 'package:otlab_controller/my_library.dart';

class DropDownSearchFood extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  late List<FoodWidgetModel> items;
  late void Function(FoodWidgetModel? value) onSaved;
  late void Function(FoodWidgetModel? value) onChange;
  late FoodWidgetModel foodModel;

  DropDownSearchFood(
      {super.key,
      required this.formKey,
      required this.onSaved,
      required this.items,
      required this.onChange,
      required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.grey,
          ),
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: DropdownSearch<FoodWidgetModel>(
          // asyncItems: (String filter) => getData(filter),
          items: items,
          key: formKey,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            isFilterOnline: true,
            title: AppTextStyle(
              name: foodModel.name,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black33,
            ),
            textStyle: GoogleFonts.cairo(
                textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black33,
            )),
            interceptCallBacks: true,
          ),
          itemAsString: (FoodWidgetModel u) => u.foodAsString(),
          onChanged: onChange,
          selectedItem: items.isNotEmpty
              ? foodModel
              : FoodWidgetModel(
                  "اختر الوجبة التي عليها خصم",
                ),
          onSaved: onSaved,
        ),
      ),
    );
  }

  Future<List<FoodWidgetModel>> getData(filter) async {
    List<FoodWidgetModel> listFood = <FoodWidgetModel>[
      FoodWidgetModel('name6'),
      FoodWidgetModel('name7'),
      FoodWidgetModel('name8'),
      FoodWidgetModel('name9'),
      FoodWidgetModel('name10'),
    ];
    // items = listFood;
    return listFood;
  }
}
