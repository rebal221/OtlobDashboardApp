import 'package:otlab_controller/my_library.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerItemHome(BuildContext context) {
  return Shimmer.fromColors(
    baseColor:
        HexColor(AppController.appData.value.primaryColor).withOpacity(0.3),
    highlightColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor(AppController.appData.value.primaryColor),
            borderRadius: BorderRadius.zero),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    ),
  );
}

Widget shimmerAds(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: AppColors.textMyInfoColor.withOpacity(0.3),
    highlightColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.textMyInfoColor,
            borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    ),
  );
}

Widget shimmerItemHomeExplore(BuildContext context) {
  return Shimmer.fromColors(
    baseColor:
        HexColor(AppController.appData.value.primaryColor).withOpacity(0.3),
    highlightColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor(AppController.appData.value.primaryColor),
            borderRadius: BorderRadius.circular(10.r)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    ),
  );
}

Widget shimmerAdsHome(BuildContext context) {
  return Padding(
      padding: EdgeInsetsDirectional.only(start: 8.w, end: 4.w),
      child: Shimmer.fromColors(
        baseColor:
            HexColor(AppController.appData.value.primaryColor).withOpacity(0.3),
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
                color: HexColor(AppController.appData.value.primaryColor),
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ));
}

Widget shimmerAdsHomWidget(
    {required BuildContext context,
    required double height,
    required double width}) {
  return Padding(
      padding: EdgeInsetsDirectional.only(start: 4.w, end: 4.w),
      child: Shimmer.fromColors(
        baseColor:
            HexColor(AppController.appData.value.primaryColor).withOpacity(0.3),
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
                color: HexColor(AppController.appData.value.primaryColor),
                borderRadius: BorderRadius.circular(20.r)),
            width: width,
            height: height,
          ),
        ),
      ));
}
