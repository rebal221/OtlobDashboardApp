import '../my_library.dart';

class CustomTextFiledAuth extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget? suffix;
  final bool isPassword;
  final TextInputType type;

  const CustomTextFiledAuth({
    Key? key,
    required this.title,
    required this.controller,
    this.suffix,
    this.isPassword = false,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63.h,
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        obscureText: isPassword,
        cursorColor: Colors.amber,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 75.h),
            suffixIcon: suffix,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
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
    );
  }
}
