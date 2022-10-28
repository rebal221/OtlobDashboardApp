import '../my_library.dart';

class CustomTextFiledAdd extends StatelessWidget {
  final String title;
  final double height;
  final TextEditingController controller;
  final TextAlign textAlign;
  final Widget? suffix;
  final bool isPassword;
  final TextInputType type;
  final bool enable;
  final bool enabledata;

  const CustomTextFiledAdd({
    Key? key,
    required this.title,
    required this.controller,
    this.suffix,
    this.enabledata = true,
    this.isPassword = false,
    this.textAlign = TextAlign.start,
    this.height = 70,
    this.enable = true,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(8.r)),
        child: TextFormField(
          enabled: enabledata,
          keyboardType: type,
          // enabled: enable,
          readOnly: enable,
          showCursor: !enable,
          controller: controller,
          obscureText: isPassword,
          cursorColor: HexColor(AppController.appData.value.primaryColor),
          textAlign: textAlign,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 50.h),
              suffixIcon: suffix,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.white,
              hintText: title,
              alignLabelWithHint: false,
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
