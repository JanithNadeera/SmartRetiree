import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_retiree/shared_widgets/hero_dialog_route.dart';
import 'package:smart_retiree/utils/toast_extension.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final rootNavigatorKey = GlobalKey<NavigatorState>();

enum ToastType { success, error, info, warning }

abstract class CoreUtils {
  const CoreUtils();

  static void postFrameCall(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void heroDialog(Widget child) {
    Navigator.push(rootNavigatorKey.currentState!.context,
        HeroDialogRoute(builder: (_) => child));
  }

  static void showBottomSheet(Widget child) {
    showModalBottomSheet(
      context: rootNavigatorKey.currentState!.context,
      builder: (context) => child,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  static void showToast({
    required ToastType type,
    required String message,
    String? title,
    SnackBarBehavior? behavior,
    int? duration,
    double? margin,
  }) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: duration ?? 3),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: margin ?? 20, left: 15, right: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          color: type.color,
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
                child: SvgPicture.asset(
                  type.icon,
                  height: 27.5,
                  width: 27.5,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? type.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () => rootScaffoldMessengerKey.currentState
                    ?.removeCurrentSnackBar(),
                child: const Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        behavior: behavior ?? SnackBarBehavior.floating,
      );

      rootScaffoldMessengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }
}
