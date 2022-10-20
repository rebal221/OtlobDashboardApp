// ignore_for_file: must_be_immutable

import 'package:flutter_animator/flutter_animator.dart';
import 'package:otlab_controller/models_widgets/drwaer_model.dart';
import 'package:otlab_controller/my_library.dart';
import 'package:otlab_controller/pages/admin_controller/main_admin_page/body_page/main_admin_page.dart';
import 'package:otlab_controller/pages/auth/auth_page/auth_page.dart';
import 'package:otlab_controller/pages/auth/auth_page/binding/auth_page_binding.dart';
import 'package:otlab_controller/widget/app_button.dart';
import 'package:otlab_controller/widget/custom_image.dart';
import 'package:otlab_controller/widget/custome_text_filed_search.dart';
import 'package:otlab_controller/widget/notifcation_widget.dart';

class MyBodyAdmin extends StatefulWidget {
  int selectedIndex = 0;
  Widget myBody;
  StateSetter setState;
  bool isFromOrderDetails = false;

  MyBodyAdmin(
      {super.key,
      required this.selectedIndex,
      required this.myBody,
      this.isFromOrderDetails = false,
      required this.setState});

  @override
  State<MyBodyAdmin> createState() => _MyBodyAdminState();
}

class _MyBodyAdminState extends State<MyBodyAdmin> {
  int selectedIndex = AppPreferences().getDataInt(key: 'sa');
  List<DrawerModel> drawerWidget = [
    DrawerModel(
      tittle: 'لوحة التحكم',
      icon: CustomSvgImage(
        imageName: 'home',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
    DrawerModel(
      tittle: 'اعدادات التطبيق',
      icon: CustomSvgImage(
        imageName: 'setting',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
    DrawerModel(
      tittle: 'التصنيفات',
      icon: CustomSvgImage(
        imageName: 'category2',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
    DrawerModel(
      tittle: 'قائمة المطاعم',
      icon: CustomSvgImage(
        imageName: 'category',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
    DrawerModel(
      tittle: 'تتبع الطلبيات',
      icon: CustomSvgImage(
        imageName: 'location',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
    DrawerModel(
      tittle: 'الاحصائيات',
      icon: CustomSvgImage(
        imageName: 'anylises',
        color: Colors.white,
        height: 18.r,
        width: 18.r,
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    widget.setState = setState;
    MainAdminPage.selectedIndex = selectedIndex;
    super.initState();
  }

  Widget bodyWidget(BuildContext context, Widget myBody) {
    return SafeArea(child: Obx(() {
      return Scaffold(
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: FadeInRight(
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          margin: EdgeInsetsDirectional.zero,
                          color:
                              HexColor(AppController.appData.value.secondColor),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: CustomImageNetwork(
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/vedesign-334b3.appspot.com/o/logo.svg?alt=media&token=4d540734-ad68-43f0-aca9-7e58f3a539f4',
                                  height: 200.h,
                                  width: 120.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0.w, vertical: 10.h),
                                child: ListView.separated(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: drawerWidget.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        debugPrint(
                                            'value is ${widget.isFromOrderDetails}');
                                        if (widget.isFromOrderDetails) {
                                          Get.to(const MainAdminPage());
                                          MainAdminPageState.stateSetter(() {
                                            selectedIndex = index;
                                            widget.selectedIndex = index;
                                            MainAdminPage.selectedIndex = index;
                                            MainAdminPageState
                                                .isClickToOrderDetails = false;

                                            setState(() {});

                                            debugPrint(
                                                'selectedIndex Drawer Model ${MainAdminPage.selectedIndex}');
                                            debugPrint(
                                                'index Drawer Model $index');
                                            debugPrint(
                                                'index Drawer Model $index');
                                            debugPrint(
                                                'isClickToOrderDetails ${MainAdminPageState.isClickToOrderDetails}');
                                          });
                                        } else {
                                          MainAdminPageState.stateSetter(() {
                                            selectedIndex = index;
                                            widget.selectedIndex = index;
                                            MainAdminPage.selectedIndex = index;
                                            MainAdminPageState
                                                .isClickToOrderDetails = false;

                                            setState(() {});

                                            debugPrint(
                                                'selectedIndex Drawer Model ${MainAdminPage.selectedIndex}');
                                            debugPrint(
                                                'index Drawer Model $index');
                                            debugPrint(
                                                'index Drawer Model $index');
                                            debugPrint(
                                                'isClickToOrderDetails ${MainAdminPageState.isClickToOrderDetails}');
                                          });
                                        }
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 8.r,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        color: selectedIndex == index
                                            ? HexColor(AppController
                                                .appData.value.primaryColor)
                                            : AppColors.drawerUnSelectedColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: ListTile(
                                            onTap: () {
                                              debugPrint(
                                                  'value is ${widget.isFromOrderDetails}');
                                              if (widget.isFromOrderDetails) {
                                                MainAdminPageState.stateSetter(
                                                    () {
                                                  selectedIndex = index;
                                                  widget.selectedIndex = index;
                                                  MainAdminPage.selectedIndex =
                                                      index;
                                                  MainAdminPageState
                                                          .isClickToOrderDetails =
                                                      false;

                                                  setState(() {});

                                                  debugPrint(
                                                      'selectedIndex Drawer Model ${MainAdminPage.selectedIndex}');
                                                  debugPrint(
                                                      'index Drawer Model $index');
                                                  debugPrint(
                                                      'index Drawer Model $index');
                                                  debugPrint(
                                                      'isClickToOrderDetails ${MainAdminPageState.isClickToOrderDetails}');
                                                });
                                                AppPreferences().setDataInt(
                                                    key: 's', value: index);
                                                Get.to(const MainAdminPage());
                                              } else {
                                                MainAdminPageState.stateSetter(
                                                    () {
                                                  selectedIndex = index;
                                                  widget.selectedIndex = index;
                                                  MainAdminPage.selectedIndex =
                                                      index;
                                                  MainAdminPageState
                                                          .isClickToOrderDetails =
                                                      false;
                                                  AppPreferences().setDataInt(
                                                      key: 's', value: index);

                                                  setState(() {});

                                                  debugPrint(
                                                      'selectedIndex Drawer Model ${MainAdminPage.selectedIndex}');
                                                  debugPrint(
                                                      'index Drawer Model $index');
                                                  debugPrint(
                                                      'index Drawer Model $index');
                                                  debugPrint(
                                                      'isClickToOrderDetails ${MainAdminPageState.isClickToOrderDetails}');
                                                });
                                              }
                                            },
                                            style: ListTileStyle.drawer,
                                            selectedColor: HexColor(
                                                AppController.appData.value
                                                    .primaryColor),
                                            selected: true,
                                            title: AppTextStyle(
                                              name: drawerWidget[index].tittle,
                                            ),
                                            leading: drawerWidget[index].icon,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 20.h,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 90.h,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0.w, vertical: 10.h),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 8.r,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    color: AppColors.drawerUnSelectedColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: ListTile(
                                        onTap: () {
                                          AppPreferences().logOutUser();

                                          Get.offAll(
                                            const AuthPage(),
                                            binding: AuthPageBinding(),
                                          );
                                        },
                                        style: ListTileStyle.drawer,
                                        selectedColor: HexColor(AppController
                                            .appData.value.primaryColor),
                                        selected: true,
                                        title: const AppTextStyle(
                                          name: 'تسجيل خروج',
                                        ),
                                        leading: CustomSvgImage(
                                          imageName: 'logout',
                                          color: Colors.white,
                                          height: 18.r,
                                          width: 18.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shrinkWrap: true,
                        children: [
                          FadeInDown(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width.w,
                              height: 90.h,
                              child: Card(
                                margin: EdgeInsetsDirectional.zero,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: SizedBox(
                                        width: 472.w,
                                        height: 60.h,
                                        child: CustomTextFiledSearch(
                                          title: 'ابحث عن وجبة، اسم مندوب،',
                                          controller: TextEditingController(),
                                          prefix: Icon(
                                            Icons.search,
                                            color: Colors.black,
                                            size: 30.r,
                                          ),
                                          suffix: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              AppButtonSearch(
                                                color: HexColor(AppController
                                                    .appData
                                                    .value
                                                    .primaryColor),
                                                title: 'بحث',
                                                onPressed: () {},
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Card(),
                                    const Spacer(),
                                    Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: notificationIconWidget()),
                                    SizedBox(
                                      width: 20.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          widget.myBody,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget(context, widget.myBody);
  }
}
