import 'package:flutter/material.dart';
import 'package:smart_retiree/utils/constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;

  const CustomTextfield({
    super.key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: Constants.blackColor),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Constants.greyColor,
        ),
      ),
    );
  }
}
