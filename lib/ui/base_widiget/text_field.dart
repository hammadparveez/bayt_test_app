import 'package:flutter/material.dart';

class ByatTextField extends StatelessWidget {
  ByatTextField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool isPassword;

  final outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: .5, color: Colors.black54),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        enabledBorder: outlineBorder,
        border: outlineBorder,
        focusedBorder: outlineBorder,
      ),
    );
  }
}
