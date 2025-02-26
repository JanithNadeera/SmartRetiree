import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;

  final AutovalidateMode? validateMode;
  const InputFormField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      this.inputFormatters,
      this.validator,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      this.validateMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: TextFormField(
        controller: controller,
        autovalidateMode: validateMode ?? AutovalidateMode.onUserInteraction,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 15.sp,
            decoration: TextDecoration.none),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.red,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontSize: 15.sp,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.black87,
            fontSize: 15.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: 14.sp,
              fontStyle: FontStyle.italic),
          prefixIcon: Padding(
            padding: EdgeInsets.all(10.h),
            child: Icon(
              prefixIcon,
              size: 25.h,
            ),
          ),
          prefixIconColor:
              WidgetStateColor.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.error)) {
              return Colors.redAccent;
            }
            return Colors.black45;
          }),
          suffixIcon: Padding(
            padding: EdgeInsets.all(10.h),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          fillColor: Colors.transparent,
          filled: false,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(8.h)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(8.h)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(8.h)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8.h)),
        ),
      ),
    );
  }
}
