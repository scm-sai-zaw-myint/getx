// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotiBar {
  _ThemeData _themeData = _ThemeData.defaultTheme();
  void show(String title, String message, String type) {
    switchType(type);
    Get.snackbar(
      title,
      message,
      backgroundColor: _themeData.bgColor,
      colorText: _themeData.color,
      snackPosition: SnackPosition.BOTTOM,
      icon: _themeData.icon,
      shouldIconPulse: true,
      borderRadius: 10,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutQuad,
      reverseAnimationCurve: Curves.easeInQuad,
      showProgressIndicator: _themeData.showProgressIndicator,
    );
  }

  void switchType(String type) {
    switch (type) {
      case "noti":
        {
          _themeData = _ThemeData.defaultTheme();
        }
        break;
      case "warning":
        {
          _themeData = _ThemeData.warningTheme();
        }
        break;
      case "error":
        {
          _themeData = _ThemeData.errorTheme();
        }
        break;
      case "loading":
        {
          _themeData = _ThemeData.loadingTheme();
        }
        break;
    }
  }
}

class _ThemeData {
  Widget icon = const Icon(Icons.check);
  Color bgColor = Colors.blue;
  Color color = Colors.white;
  bool showProgressIndicator = false;

  _ThemeData.defaultTheme()
      : icon = const Icon(
          Icons.check,
          color: Colors.white,
        ),
        bgColor = Colors.blue,
        color = Colors.white;
  _ThemeData.warningTheme()
      : icon = const Icon(
          Icons.warning,
          color: Colors.black12,
        ),
        bgColor = Colors.orange,
        color = Colors.black12;
  _ThemeData.errorTheme()
      : icon = const Icon(
          Icons.error_outline,
          color: Colors.black12,
        ),
        bgColor = Colors.redAccent,
        color = Colors.black12;
  _ThemeData.loadingTheme()
      : icon = const Icon(Icons.refresh),
        bgColor = Colors.white,
        color = Colors.black,
        showProgressIndicator=true;
}
