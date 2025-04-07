import 'dart:ui';
import 'package:smart_retiree/utils/core_utils.dart';

extension ToastExt on ToastType {
  String get icon {
    return switch (this) {
      ToastType.success => "assets/icons/toast_success.svg",
      ToastType.error => "assets/icons/toast_error.svg",
      ToastType.info => "assets/icons/toast_info.svg",
      ToastType.warning => "assets/icons/toast_warning.svg"
    };
  }

  String get title {
    return switch (this) {
      ToastType.success => "Success",
      ToastType.error => "Error",
      ToastType.info => "Infomation",
      ToastType.warning => "Warning"
    };
  }

  Color get color {
    return switch (this) {
      ToastType.success => const Color(0xFF3FAE36),
      ToastType.error => const Color(0xFFF9472F),
      ToastType.info => const Color(0xFF4E91D5),
      ToastType.warning => const Color(0xFFFEC219)
    };
  }
}
