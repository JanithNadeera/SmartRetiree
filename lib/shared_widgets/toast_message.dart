import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum ToastType { success, error, info, warning }

extension ToastColor on ToastType {
  Color color() {
    switch (this) {
      case ToastType.success:
        return const Color(0xFF3FAE36);
      case ToastType.error:
        return const Color(0xFFF9472F);
      case ToastType.info:
        return const Color(0xFF4E91D5);
      case ToastType.warning:
        return const Color(0xFFFEC219);
      default:
        return const Color(0xFF3FAE36);
    }
  }
}

extension ToastIcon on ToastType {
  String icon() {
    switch (this) {
      case ToastType.success:
        return "assets/icons/toast_success.svg";
      case ToastType.error:
        return "assets/icons/toast_error.svg";
      case ToastType.info:
        return "assets/icons/toast_info.svg";
      case ToastType.warning:
        return "assets/icons/toast_warning.svg";
      default:
        return "assets/icons/toast_success.svg";
    }
  }
}

extension ToastTitle on ToastType {
  String title() {
    switch (this) {
      case ToastType.success:
        return "Success";
      case ToastType.error:
        return "Error";
      case ToastType.info:
        return "Infomation";
      case ToastType.warning:
        return "Warning";
      default:
        return "Success";
    }
  }
}

SnackBar toast(
    {required ToastType type,
    required String message,
    SnackBarBehavior? behavior,
    int? duration,
    double? margin}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: duration ?? 5),
    padding: EdgeInsets.zero,
    margin: EdgeInsets.only(bottom: margin ?? 20.h, left: 15.w, right: 15.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      color: type.color(),
      child: Row(
        children: [
          Container(
            height: 35.w,
            width: 35.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
            child: SvgPicture.asset(
              type.icon(),
              height: 27.5.w,
              width: 27.5.w,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.title(),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          GestureDetector(
            onTap: () =>
                rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar(),
            child: Icon(
              Icons.close_rounded,
              size: 25.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    behavior: behavior ?? SnackBarBehavior.floating,
  );
}
