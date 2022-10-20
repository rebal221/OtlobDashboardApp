// ignore_for_file: must_be_immutable
import 'package:flutter_animator/flutter_animator.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/server/model/category_model.dart';
import 'package:otlab_controller/widget/drop_down_serach_category.dart';
import 'package:otlab_controller/widget/list_food_widget.dart';

class ListFoodBody extends StatefulWidget {
  StateSetter setState;

  ListFoodBody({super.key, required this.setState});
  @override
  State<ListFoodBody> createState() => _ListFoodBodyState();
}

class _ListFoodBodyState extends State<ListFoodBody> {
  final ScrollController controller = ScrollController();
  final _formKeyDropDownCategory = GlobalKey<FormState>();

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
                labelText: 'قائمة الطعام',
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
                labelText: 'اضافة وجبة جديدة',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                  height: 370.h,
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
                              tittle: 'اسم الوجبة',
                              hint: 'أدخل اسم الوجبة',
                              controller: TextEditingController(),
                              type: TextInputType.text,
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
                                          name: ' تصنيف الوجبة',
                                          fontSize: 22.sp,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 70.h,
                                          child: DropDownSearchCategory(
                                            categoryModel: CategoryModel.add(
                                              uid: '',
                                              name: 'مثال (بيتزا)',
                                              image: '',
                                              color: '',
                                            ),
                                            formKey: _formKeyDropDownCategory,
                                            onSaved: (CategoryModel? value) {},
                                            onChange:
                                                (CategoryModel? value) async {
                                              if (value != null) {
                                                // controller.selectedCategory
                                                //     .value = value;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          SizedBox(
                            width: 400.w,
                            child: TextFieldAdd(
                              width: 400.w,
                              tittle: 'سعر الوجبة',
                              hint: 'أدخل سعر الوجبة',
                              controller: TextEditingController(),
                              type: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 400.w,
                            child: TextFieldAdd(
                              width: 400.w,
                              tittle: 'وصف الوجبة',
                              hint: 'أدخل وصف الوجبة',
                              controller: TextEditingController(),
                              type: TextInputType.multiline,
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          SizedBox(
                            height: 210.h,
                            width: 850.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextStyle(
                                  name: 'صور للوجبة',
                                  fontSize: 22.sp,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 180.w,
                                        height: 150.h,
                                        child: Card(
                                          child: Center(
                                            child: Icon(
                                                Icons
                                                    .photo_size_select_actual_rounded,
                                                color: Colors.black,
                                                size: 75.r),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    SizedBox(
                                        width: 180.w,
                                        height: 150.h,
                                        child: Card(
                                          child: Center(
                                            child: Icon(
                                                Icons
                                                    .photo_size_select_actual_rounded,
                                                color: Colors.black,
                                                size: 75.r),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    SizedBox(
                                        width: 180.w,
                                        height: 150.h,
                                        child: Card(
                                          child: Center(
                                            child: Icon(
                                                Icons
                                                    .photo_size_select_actual_rounded,
                                                color: Colors.black,
                                                size: 75.r),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 60.w,
                                    ),
                                    SizedBox(
                                      width: 95.w,
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        color: HexColor(AppController
                                            .appData.value.primaryColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: AppTextStyle(
                                            name: 'اضافة الوجبة',
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(
                                      width: 94.w,
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        color: HexColor(AppController
                                            .appData.value.secondColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: AppTextStyle(
                                            name: 'إلغاء',
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
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
