import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_retiree/utils/core_utils.dart';

class Loader {
  static void show(bool isLoading) {
    final context = rootNavigatorKey.currentState!.context;
    if (isLoading && !(context.loaderOverlay.visible)) {
      context.loaderOverlay.show();
    }
    if (!isLoading && context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  static Widget indicator({Color? color, double size = 40}) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: LoadingIndicator(
            indicatorType: Indicator.lineSpinFadeLoader,
            colors: [color ?? Colors.white],
            strokeWidth: 2.0),
      ),
    );
  }
}
