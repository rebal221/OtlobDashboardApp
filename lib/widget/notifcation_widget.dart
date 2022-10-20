import '../my_library.dart';

Widget notificationIconWidget() {
  return SizedBox(
    width: 35.w,
    height: 35.h,
    child: Stack(
      children: [
        Icon(
          Icons.notifications,
          color: Colors.black,
          size: 35.r,
        ),
        Container(
          width: 30.w,
          height: 30.h,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(bottom: 10.h),
          child: Container(
            width: 20.h,
            height: 20.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1.w)),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: AppTextStyle(
                  name: '2',
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
