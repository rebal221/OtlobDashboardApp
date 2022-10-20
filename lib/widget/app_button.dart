import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otlab_controller/widget/loading2.dart';

import 'app_style_text.dart';

@immutable
class AppButton extends StatefulWidget {
  final String title;
  final double fontSize;
  final double borderRadiusButton;
  final Color color;
  final void Function() onPressed;
  final double height;
  final bool isLoading;

  const AppButton(
      {Key? key,
      required this.color,
      this.fontSize = 30,
      this.isLoading = false,
      this.height = 70,
      this.borderRadiusButton = 12,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, widget.height.h),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadiusButton.r),
          )),
      child: widget.isLoading
          ? const Loading2()
          : AppTextStyle(
              name: widget.title,
              fontSize: widget.fontSize.sp,
              color: Colors.white,
            ),
    );
  }
}

class AppButtonSearch extends StatefulWidget {
  final String title;
  final Color color;
  final void Function() onPressed;

  const AppButtonSearch(
      {Key? key,
      required this.color,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  State<AppButtonSearch> createState() => _AppButtonSearchState();
}

class _AppButtonSearchState extends State<AppButtonSearch> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(74.w, 50.h),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          )),
      child: AppTextStyle(
        name: widget.title,
        fontSize: 20.sp,
        color: Colors.white,
      ),
    );
  }
}
