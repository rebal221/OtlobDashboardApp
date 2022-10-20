// ignore_for_file: must_be_immutable

import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/widget/row_icon.dart';

import '../../../../../../widget/app_button.dart';

class TrackingOrderBody extends StatefulWidget {
  StateSetter setState;

  TrackingOrderBody({super.key, required this.setState});

  @override
  State<TrackingOrderBody> createState() => _TrackingOrderBodyState();
}

class _TrackingOrderBodyState extends State<TrackingOrderBody> {
  final ScrollController controller = ScrollController();
  final ScrollController controller1 = ScrollController();

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
    return myBodyWidget(context);
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
          FadeInUp(
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 35.r, vertical: 30.r),
                labelText: 'قائمة المناديب',
                labelStyle: GoogleFonts.cairo(
                    textStyle: TextStyle(
                  color: HexColor(AppController.appData.value.secondColor),
                  fontSize: 30.sp,
                )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
              child: SizedBox(
                height: 900.h,
                width: 1600.w,
                child: GridView.builder(
                  controller: controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 169.w / 42.h,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 150.h,
                        width: 169.w,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // scrollDirection: Axis.horizontal,
                              // clipBehavior: Clip.antiAliasWithSaveLayer,
                              // // controller: controller2,
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Row(
                                  children: [
                                    SizedBox.fromSize(
                                        size: const Size.fromRadius(50),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              ExtendedNetworkImageProvider(
                                            'data:image/jpeg;base64,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',
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        AppTextStyle(
                                          name: 'مصطفى سعد الدين محمد',
                                          count: 2,
                                          color: AppColors.greyE,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 120.w,
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.r)),
                                                color: AppColors.grey,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.r),
                                                  child: AppTextStyle(
                                                    name: 'سيارة هيونداي',
                                                    color: Colors.black,
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            SizedBox(
                                              width: 120.w,
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.r)),
                                                color: AppColors.grey,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.r),
                                                  child: AppTextStyle(
                                                    name: 'يبعد 0.3 كلم',
                                                    color: Colors.black,
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25.w,
                                            ),
                                            RowIcon(
                                                title: 'حذف السائق',
                                                fontColor: Colors.red,
                                                fontSize: 16,
                                                iconData: Icons
                                                    .delete_outline_outlined,
                                                color: Colors.red),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        height: 50.h,
                                        child: AppButton(
                                            color: HexColor(AppController
                                                .appData.value.primaryColor),
                                            title: 'تتبع على الخريطة',
                                            onPressed: () {
                                              MapsLauncher.launchCoordinates(
                                                  37.4220041,
                                                  -122.0862462,
                                                  'Google Headquarters are here');
                                            }),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        width: 150.w,
                                        height: 50.h,
                                        child: AppButton(
                                            title: 'اتصال السائق',
                                            onPressed: () {},
                                            color: Colors.grey.shade900),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
