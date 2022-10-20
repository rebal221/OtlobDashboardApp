import 'package:otlab_controller/widget/custom_image.dart';

import '../my_library.dart';

class CardTemplateTransparent extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData? suffix;
  final String? prefix;

  const CardTemplateTransparent(
      {Key? key,
      required this.title,
      required this.controller,
      this.suffix,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.h,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   color: AppColors.grey,
            //
            // ),
            borderRadius: BorderRadius.circular(8.r)),
        // elevation: 5.r,
        child: TextField(
          controller: controller,
          cursorColor: HexColor(AppController.appData.value.primaryColor),
          decoration: InputDecoration(
            suffixIcon: Icon(
              suffix,
              color: AppColors.greyCC,
              size: 18.r,
            ),
            prefixIconConstraints: BoxConstraints.tight(Size(40.w, 16.h)),
            prefixIcon: CustomSvgImage(
              imageName: prefix,
              color: AppColors.grey,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
                borderRadius: BorderRadius.circular(8.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
                borderRadius: BorderRadius.circular(8.r)),
            labelStyle: const TextStyle(color: Colors.white),
            fillColor: Colors.white,
            label: AppTextStyle(
              name: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
