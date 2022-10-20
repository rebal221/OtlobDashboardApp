import 'package:extended_image_library/extended_image_library.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/widget/row_icon.dart';

class ListFoodWidget extends StatelessWidget {
  const ListFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160.h,
        width: 169.w,
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: ListView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // controller: controller2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox.fromSize(
                    size: const Size.fromRadius(50),
                    child: CircleAvatar(
                      backgroundImage: ExtendedNetworkImageProvider(
                        'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=768,574',
                      ),
                    )),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextStyle(
                      name: 'سندوتش فلافل',
                      count: 2,
                      color: AppColors.greyE,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    AppTextStyle(
                      name: 'وجبة  فلافل تكفي 5 أفراد',
                      count: 2,
                      color: AppColors.greyE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      children: [
                        RowIcon(
                          title: '30 ليرة',
                          fontSize: 22.sp,
                          iconData: Icons.monetization_on,
                          color: AppColors.greyE,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        RowIcon(
                          title: 'سندوتشات',
                          fontSize: 22.sp,
                          iconData: Icons.list,
                          color: AppColors.greyE,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 260.w,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          color: HexColor(
                              AppController.appData.value.primaryColor),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: AppTextStyle(
                              name: 'تعديل',
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
                        width: 90.w,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          color:
                              HexColor(AppController.appData.value.secondColor),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: AppTextStyle(
                              name: 'حذف',
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
                ),
              ],
            ),
          ),
        ));
  }
}
