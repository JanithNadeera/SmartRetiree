import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool obscureText;
  final int? maxLength;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? initialValue;
  final void Function(String)? onChanged;
  const InputField({
    super.key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.prefixIcon,
    this.maxLength,
    this.width,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.initialValue,
    this.onChanged,
    this.labelText,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.maxFinite,
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget.controller,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        style: context.bodyLarge,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.red,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText ? isHide : widget.obscureText,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          labelText: widget.labelText,
          hintText: widget.hintText,
          counterText: "",
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () => setState(() => isHide = !isHide),
                  icon: Icon(
                    isHide
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
