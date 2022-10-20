import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_style_text.dart';

@immutable
class AppButtonIcon extends StatefulWidget {
  final String title;
  final Color color;
  final Widget icon;
  final double height;
  final double width;

  final void Function() onPressed;

  const AppButtonIcon(
      {Key? key,
      required this.color,
      this.height = 26,
      this.width = 13,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButtonIcon> createState() => _AppButtonIconState();
}

class _AppButtonIconState extends State<AppButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          // padding: EdgeInsetsDirectional.only(start: 10.w),
          minimumSize: Size(double.infinity, 50.h),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          )),
      child: Row(
        children: [
          // const Spacer(),
          SizedBox(
            width: 2.w,
          ),
          widget.icon,
          SizedBox(
            width: 10.w,
          ),

          Expanded(
            flex: 2,
            child: AppTextStyle(
              textAlign: TextAlign.start,
              name: widget.title,
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          // const Spacer(),
          SizedBox(
            width: 2.w,
          ),

          // Spacer(),
        ],
      ),
    );
  }
}
