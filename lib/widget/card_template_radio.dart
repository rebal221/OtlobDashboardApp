// ignore_for_file: must_be_immutable
import 'package:otlab_controller/widget/custom_image.dart';

import '../my_library.dart';

class CardTemplateRadio extends StatelessWidget {
  String image;

  Widget widget;
  double heigth;
  bool click;

  void Function() onPressed;

  CardTemplateRadio({
    Key? key,
    this.heigth = 10,
    required this.click,
    required this.onPressed,
    required this.widget,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 53.h,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: click
              ? HexColor(AppController.appData.value.primaryColor)
                  .withOpacity(.2)
              : AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: click
                    ? HexColor(AppController.appData.value.primaryColor)
                    : AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                    child: RadioListTile(
                  activeColor:
                      HexColor(AppController.appData.value.primaryColor),
                  title: widget,
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                )),
                CustomSvgImage(
                  imageName: image,
                  height: heigth,
                  width: 26.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
