// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';
import 'package:otlab_controller/server/model/category_model.dart';

class DropDownSearchCategory extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  late void Function(CategoryModel? value) onSaved;
  late void Function(CategoryModel? value) onChange;
  CategoryControllerReadData controller = Get.find();
  late CategoryModel categoryModel;

  DropDownSearchCategory({
    super.key,
    required this.formKey,
    required this.onSaved,
    required this.onChange,
    required this.categoryModel,
  });

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
        child: DropdownSearch<CategoryModel>(
          // asyncItems: (String filter) => getData(filter),
          items: controller.listCategory.value,
          key: formKey,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            isFilterOnline: true,
            title: AppTextStyle(
              name: controller.listCategory.value.first.name,
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
          itemAsString: (CategoryModel u) => u.categoryAsString(),
          onChanged: onChange,

          selectedItem: controller.listCategory.isNotEmpty
              ? categoryModel
              : CategoryModel.add(
                  uid: '',
                  name: 'مثال (بيتزا)',
                  image: '',
                  color: '',
                ),
          onSaved: onSaved,
        ),
      ),
    );
  }
}
