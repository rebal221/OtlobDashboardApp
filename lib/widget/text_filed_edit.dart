// ignore_for_file: must_be_immutable

import 'package:otlab_controller/my_library.dart';

import 'custome_text_filed_edit.dart';

class TextFieldEdit extends StatelessWidget {
  String hint = '';
  String tittle = '';
  double width;
  double widthSizeBox;
  double height;
  double heightSizeBox;
  bool enable = true;
  Widget? suffix;
  TextInputType type = TextInputType.text;
  TextEditingController controller = TextEditingController();
  final TextAlign textAlign;
  final int maxLines;

  TextFieldEdit(
      {super.key,
      required this.tittle,
      required this.hint,
      this.type = TextInputType.text,
      this.enable = true,
      this.maxLines = 1,
      this.textAlign = TextAlign.start,
      this.height = 70,
      this.heightSizeBox = 140,
      this.widthSizeBox = 400,
      this.suffix,
      required this.width,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSizeBox.h,
      width: width.w,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: heightSizeBox.h,
              width: widthSizeBox.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextStyle(
                    name: tittle,
                    fontSize: 22.sp,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFiledEdit(
                    title: hint,
                    controller: controller,
                    type: type,
                    enable: enable,
                    maxLines: maxLines,
                    suffix: suffix,
                    height: height.h,
                    textAlign: textAlign,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
