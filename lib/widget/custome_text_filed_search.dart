import '../my_library.dart';

class CustomTextFiledSearch extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? prefix;
  final bool isPassword;
  final TextInputType type;

  const CustomTextFiledSearch({
    Key? key,
    required this.title,
    required this.controller,
    this.suffix,
    this.prefix,
    this.isPassword = false,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsetsDirectional.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: TextFormField(
          keyboardType: type,
          controller: controller,
          obscureText: isPassword,
          cursorColor: HexColor(AppController.appData.value.primaryColor),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 50.h),
              suffixIcon: suffix,
              prefixIcon: prefix,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 0.40.w),
                borderRadius: BorderRadius.circular(50.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 0.40.w),
                borderRadius: BorderRadius.circular(50.r),
              ),
              fillColor: Colors.white,
              hintText: title,
              alignLabelWithHint: true,
              hintStyle: GoogleFonts.cairo(
                  textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.greyC,
              ))),
        ),
      ),
    );
  }
}
