import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color hintTextColor;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool obscureText;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final bool showSuffixIcon;
  final IconData? iconsData;
  final GestureTapCallback? onSuffixTap;

  const CommonTextFormField({
    Key? key,
    @required this.controller,
    @required this.hintText,
    this.hintTextColor = ColorConstant.black,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.prefixIconColor = ColorConstant.darkBlue,
    this.inputFormatters,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.showSuffixIcon = false,
    this.iconsData,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      style: TextStyle(
        color: hintTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText!,
        hintStyle: const TextStyle().copyWith(color: hintTextColor),
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: prefixIconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            prefixIcon,
            size: 16,
            color: prefixIconColor,
          ),
        ),
        contentPadding: EdgeInsets.zero,
        suffixIcon: showSuffixIcon
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(iconsData, color: ColorConstant.darkBlue, size: 22),
              )
            : const SizedBox(),
      ),
    );
  }
}
