import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_network/image_network.dart';
import 'package:otlab_controller/server/controller/app_controller.dart';

class CustomPngImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomPngImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpgImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpg',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpegImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpegImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpeg',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFitWeb? boxFit;
  final Color? color;
  final bool isFull;

  const CustomImageNetwork({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.boxFit,
    this.color,
    this.isFull = false,
  });

  @override
  Widget build(BuildContext context) {
    return ImageNetwork(
      image: imageUrl ?? '',
      imageCache: CachedNetworkImageProvider(
        maxHeight: 1000,
        maxWidth: 1000,
        imageUrl ?? '',
      ),
      height: height ?? 30.h,
      width: width ?? 30.w,
      duration: 1,
      onPointer: true,
      debugPrint: true,
      fullScreen: isFull,
      // fitAndroidIos: boxFit ?? BoxFit.contain,
      fitWeb: boxFit ?? BoxFitWeb.contain,
      onLoading: CircularProgressIndicator(
        color: Colors.amber,
        strokeWidth: 2.r,
        backgroundColor: Colors.white,
      ),
      // onLoading: shimmerAdsHomWidget(
      //     context: context, width: width ?? 30.w, height: height ?? 30.h),
      onError: const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}

class CustomSvgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? boxFit;

  const CustomSvgImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.color,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/$imageName.svg',
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      color: color,
    );
  }
}
