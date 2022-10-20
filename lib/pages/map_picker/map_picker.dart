// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as app;
import 'package:hexcolor/hexcolor.dart';
import 'package:map_picker/map_picker.dart';

import '../../server/controller/app_controller.dart';
import '../../value/colors.dart';
import '../../widget/app_button.dart';
import '../../widget/card_template_black.dart';

class MapPickerScreen extends StatefulWidget {
  app.LatLng latLng;
  bool isFromLaunch;

  MapPickerScreen({super.key, required this.latLng, this.isFromLaunch = false});

  @override
  MapPickerScreenState createState() => MapPickerScreenState();
}

class MapPickerScreenState extends State<MapPickerScreen> {
  final _controller = Completer<app.GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  late app.LatLng currentPostion;

  late app.CameraPosition cameraPosition;

  var textController = TextEditingController();
  AppController appController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    cameraPosition = app.CameraPosition(
      target: app.LatLng(widget.latLng.latitude, widget.latLng.longitude),
      zoom: 14.4746,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapPicker(
              // pass icon widget
              iconWidget: SvgPicture.asset(
                "images/location_icon.svg",
                height: 60,
              ),
              //add map picker controller
              mapPickerController: mapPickerController,
              child: app.GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                // hide location button
                myLocationButtonEnabled: false,
                mapType: app.MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (app.GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving!();
                  textController.text = "جاري الفحص ...";
                },
                onCameraMove: (cameraPosition) {
                  this.cameraPosition = cameraPosition;
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving!();
                  //get address name from camera position
                  List<Placemark> placemarks =
                      await GeocodingPlatform.instance.placemarkFromCoordinates(
                    cameraPosition.target.latitude,
                    cameraPosition.target.longitude,
                    localeIdentifier: '',
                  );
                  textController.text =
                      '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                },
              ),
            ),
            Positioned(
              top: 35.h,
              bottom: 20.h,
              left: 24.w,
              right: 24.w,
              child: Column(
                children: [
                  AppButton(
                    title: 'من فضلك اختر مكان التوصيل',
                    onPressed: () {},
                    color: AppColors.black.withOpacity(.1),
                    fontSize: 13.sp,
                    height: 41.h,
                  ),
                  const Spacer(),
                  CardTemplateBlack(
                      prefix: 'maps',
                      enable: true,
                      title: 'العنوان',
                      colorFont: AppColors.black,
                      controller: textController),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                    color: HexColor(AppController.hexColorPrimary.value),
                    title: ' التالي',
                    onPressed: () async {
                      await nextStep();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> nextStep() async {
    log("Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
    log("Address: ${textController.text}");
  }

// Future<void> _getUserLocation() async {
//   LocationPermission permission;
//   Position position;
//   permission = await Geolocator.requestPermission();
//   debugPrint(permission.toString());
//   if (await Geolocator.isLocationServiceEnabled()) {
//     position = await Geolocator.getCurrentPosition();
//     if (!position.longitude.isNaN) {
//       if (mounted) {
//         setState(() {
//           currentPostion = LatLng(position.latitude, position.longitude);
//         });
//       }
//     }
//   } else {
//     position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     if (!position.longitude.isNaN) {
//       if (mounted) {
//         setState(() {
//           currentPostion = LatLng(position.latitude, position.longitude);
//         });
//       }
//     }
//   }
//   cameraPosition = CameraPosition(
//     target: currentPostion,
//     zoom: 14.4746,
//   );
// }
}
