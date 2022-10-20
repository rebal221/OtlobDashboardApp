import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:location/location.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/auth/auth_page/controller/auth_page_controller.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/custome_text_filed_auth.dart';
import 'package:otlab_controller/widget/show_loading_card.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _selectedIndex = 0;
  bool isPassword = true;
  bool isForgetPassword = false;
  final AppController controller = Get.find();
  final AuthPageController authController = Get.find();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  AppController appController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: BlurryModalProgressHUD(
          inAsyncCall: AuthPageController.isLoading.value,
          blurEffectIntensity: 4,
          dismissible: false,
          progressIndicator: ShowcaseCard(
            child: Image.asset(cupertinoActivityIndicator, scale: 2),
          ),
          opacity: 0.4,
          child: Stack(
            children: [
              CustomImageNetwork(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/vedesign-334b3.appspot.com/o/image%203.png?alt=media&token=593cdbce-68a7-4b2b-932a-528fa2136017',
                height: 2000.h,
                width: 4000.w,
                isFull: true,
              ),
              Container(
                color: AppColors.black.withOpacity(.5),
                height: double.infinity,
                width: double.infinity,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120.w,
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: SizedBox(
                        height: 593.h,
                        width: 490.w,
                        child: Card(
                          margin: EdgeInsetsDirectional.zero,
                          color: Colors.white.withOpacity(0.94),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.zero,
                                child: FlutterToggleTab(
                                  width: 27.w,
                                  height: 59.h,
                                  borderRadius: 5.r,
                                  unSelectedBackgroundColors: const [
                                    Colors.white
                                  ],
                                  isShadowEnable: true,
                                  isScroll: false,
                                  marginSelected: EdgeInsets.zero,
                                  selectedBackgroundColors: [
                                    HexColor(AppController
                                        .appData.value.primaryColor)
                                  ],
                                  selectedTextStyle: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700)),
                                  unSelectedTextStyle: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal)),
                                  labels: const [
                                    "تسجيل دخول مطعم",
                                    "انشاء حساب جديد",
                                  ],
                                  selectedLabelIndex: (index) {
                                    if (mounted) {
                                      setState(() {
                                        _selectedIndex = index;
                                        isForgetPassword = false;
                                      });
                                    }
                                    debugPrint("Selected Index $index");
                                  },
                                  selectedIndex: _selectedIndex,
                                ),
                              ),
                              isForgetPassword
                                  ? forgetPasswordView(context)
                                  : view(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140.w,
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: CustomImageNetwork(
                        imageUrl: AppController.appData.value.appLogo,
                        height: 300.h,
                        width: 160.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget loginView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40.h,
          ),
          AppTextStyle(
            name: 'البريد الالكتروني',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
              title: 'البريد الإلكتروني',
              controller: authController.email,
              type: TextInputType.emailAddress),
          SizedBox(
            height: 20.h,
          ),
          AppTextStyle(
            name: 'كلمة السر',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
            title: 'كلمة السر',
            controller: authController.password,
            isPassword: isPassword,
            type: TextInputType.visiblePassword,
            suffix: GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    isPassword = !isPassword;
                  });
                }
              },
              child: Icon(
                  isPassword ? Icons.visibility : Icons.visibility_off_rounded,
                  color: Colors.black.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  //ToDo:change view to  forget password view

                  if (mounted) {
                    setState(() {
                      isForgetPassword = true;
                    });
                  }
                },
                child: AppTextStyle(
                  name: "هل نسيت كلمة المرور ؟",
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
          SizedBox(
            height: 65.h,
          ),
          AppButton(
              color: HexColor(AppController.appData.value.primaryColor),
              title: 'تسجيل دخول',
              onPressed: () {
                authController.login(context);
                // Get.offAll(const MainAdminPage());
              }),
        ],
      ),
    );
  }

  Widget createAccountView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40.h,
          ),
          AppTextStyle(
            name: 'البريد الالكتروني',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
              title: 'البريد الإلكتروني',
              controller: authController.email,
              type: TextInputType.emailAddress),
          SizedBox(
            height: 20.h,
          ),
          AppTextStyle(
            name: 'كلمة السر',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
            title: 'كلمة السر',
            controller: authController.password,
            isPassword: isPassword,
            type: TextInputType.visiblePassword,
            suffix: GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    isPassword = !isPassword;
                  });
                }
              },
              child: Icon(
                  isPassword ? Icons.visibility : Icons.visibility_off_rounded,
                  color: Colors.black.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppTextStyle(
            name: 'كلمة السر مرة أخرى',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
            title: 'كلمة السر مرة أخرى',
            controller: authController.confirmPassword,
            isPassword: isPassword,
            type: TextInputType.visiblePassword,
            suffix: GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    isPassword = !isPassword;
                  });
                }
              },
              child: Icon(
                  isPassword ? Icons.visibility : Icons.visibility_off_rounded,
                  color: Colors.black.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          AppButton(
              color: HexColor(AppController.appData.value.primaryColor),
              title: 'إنشاء الحساب',
              onPressed: () async {
                await authController.createAccount(context);
                // AuthPageController().addAdmin(context);
              }),
        ],
      ),
    );
  }

  Widget forgetPasswordView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80.h,
          ),
          AppTextStyle(
            name: 'البريد الالكتروني',
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextFiledAuth(
              title: 'البريد الإلكتروني',
              controller: authController.email,
              type: TextInputType.emailAddress),
          SizedBox(
            height: 65.h,
          ),
          AppButton(
              color: HexColor(AppController.appData.value.primaryColor),
              title: 'إرسال',
              onPressed: () async {
                await authController.forgetPassword(context);
              }),
        ],
      ),
    );
  }

  Widget view() {
    if (_selectedIndex == 0) {
      return loginView(context);
    }
    if (_selectedIndex == 1) {
      return createAccountView(context);
    }

    return const Card();
  }

  ///ToDo : Here Logic BackEnd
  ///
  ///

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        final locationData = await location.getLocation();
        if (mounted) {
          setState(() {
            AppPreferences()
                .setData(key: 'lat', value: locationData.latitude.toString());
            AppPreferences()
                .setData(key: 'long', value: locationData.longitude.toString());
          });
        }
        return;
      }
    }

    final locationData = await location.getLocation();
    if (mounted) {
      setState(() {
        AppPreferences()
            .setData(key: 'lat', value: locationData.latitude.toString());
        AppPreferences()
            .setData(key: 'long', value: locationData.longitude.toString());
      });
    }
  }
}
