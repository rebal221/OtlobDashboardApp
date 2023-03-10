// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';
import 'app_style_text.dart';

class RowIcon extends StatelessWidget {
  // const RowIcon({
  //   Key? key,
  // }) : super(key: key);
  String title;
  double fontSize;

  IconData iconData;
  Color color;
  Color fontColor;

  RowIcon(
      {super.key,
      this.fontSize = 6,
      this.fontColor = AppColors.greyE,
      required this.title,
      required this.iconData,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData, size: 20.r, color: color),
        SizedBox(
          width: 2.w,
        ),
        AppTextStyle(
          textAlign: TextAlign.center,
          name: title,
          isMarai: false,
          fontSize: fontSize.sp,
          color: fontColor,
          // fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
