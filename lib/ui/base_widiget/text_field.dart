import 'package:bayt_test_app/util/colors.dart';
import 'package:flutter/material.dart';

class ByatTextField extends StatelessWidget {
  ByatTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.textColor,
    this.cursorColor,
    this.hintText,
    this.isPassword = false,
    this.showBorder = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon, suffixIcon;
  final String? hintText;
  final bool isPassword;
  final bool showBorder;
  final Color? prefixIconColor, suffixIconColor, textColor, cursorColor;

  final outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: .5, color: Colors.black54),
  );

  @override
  Widget build(BuildContext context) {
    final isSuffixIcon = suffixIcon.runtimeType == Icon;
    final isPrefixIcon = suffixIcon.runtimeType == Icon;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      obscureText: isPassword,
      style: TextStyle(color: textColor),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        suffixIcon: isSuffixIcon
            ? IconTheme(
                data: IconThemeData(color: suffixIconColor),
                child: suffixIcon ?? const SizedBox())
            : const SizedBox(),
        prefixIcon: isPrefixIcon
            ? IconTheme(
                data: IconThemeData(color: prefixIconColor),
                child: prefixIcon ?? const SizedBox())
            : const SizedBox(),
        hintText: hintText,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        enabledBorder: showBorder ? outlineBorder : InputBorder.none,
        border: showBorder ? outlineBorder : InputBorder.none,
        focusedBorder: showBorder ? outlineBorder : InputBorder.none,
      ),
    );
  }
}
