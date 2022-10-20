import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otlab_controller/lanugage/app_get.dart';
import 'package:otlab_controller/lanugage/localString.dart';
import 'package:otlab_controller/pages/welcome/start_screen.dart';
import 'package:otlab_controller/server/controller/read_category_controller.dart';
import 'package:otlab_controller/services/preferences/app_preferences.dart';
import 'package:otlab_controller/value/colors.dart';

import 'network/network_controller.dart';
import 'server/controller/app_controller.dart';
import 'server/controller/user_controller.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().initPreferences();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAG84Yqshb111HQdnGa-PB4anJNRqSDaO8',
        appId: '1:807521768320:web:2e2aff9c24d4d49868a765',
        messagingSenderId: '807521768320',
        projectId: 'otlobdriverapp-dd897',
        authDomain: 'otlobdriverapp-dd897.firebaseapp.com',
        storageBucket: 'otlobdriverapp-dd897.appspot.com',
        measurementId: 'G-8L0MK1K6S9'),
  );
  Get.put(AppController(), permanent: true);
  Get.put(AppGet(), permanent: true);
  Get.put(NetworkController(), permanent: true);
  Get.put(UserController(), permanent: true);
  if (AppPreferences().loggedIn) {
    Get.put(CategoryControllerReadData(), permanent: true);
  }
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1728, 1127),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return GetMaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          // initialBinding: NetworkBinding(),
          builder: (context, widget) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),

            textTheme: TextTheme(
                titleSmall: TextStyle(color: AppColors.white, fontSize: 14.sp)),

            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              // brightness: Brightness.dark,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: false,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          translations: LocalString(),
          locale: Locale(AppPreferences().getLanguageCode,
              AppPreferences().getCountryCode),
          home: const StartScreen(),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
