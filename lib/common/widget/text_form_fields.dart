import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';
import 'package:payment_integration_demo/common/widget/common_text_form_field.dart';

CommonTextFormField emailTextFormField(
    TextEditingController controller, String hintText) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    keyboardType: TextInputType.emailAddress,
    prefixIcon: Icons.alternate_email,
  );
}

CommonTextFormField passwordTextFormField(TextEditingController controller,
    String hintText, bool obscureText, GestureTapCallback onSuffixTap) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    keyboardType: TextInputType.visiblePassword,
    obscureText: obscureText,
    textInputAction: TextInputAction.done,
    prefixIcon: Icons.lock_open,
    onSuffixTap: onSuffixTap,
    showSuffixIcon: true,
    iconsData: obscureText ? Icons.visibility : Icons.visibility_off,
  );
}

CommonTextFormField nameTextFormField(
    TextEditingController controller, String hintText,
    {IconData prefixIcon = Icons.perm_identity_outlined,
    TextInputType? keyboardType = TextInputType.name,
    int maxLines = 1}) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    keyboardType: keyboardType,
    prefixIcon: prefixIcon,
    maxLines: maxLines,
  );
}

CommonTextFormField numberTextFormField(
    TextEditingController controller, String hintText,
    {int numLimit = 10, IconData prefixIcon = Icons.phone}) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(numLimit),
    ],
    prefixIcon: prefixIcon,
  );
}

CommonTextFormField searchTextFormField(TextEditingController controller,
    String hintText, ValueChanged<String> onChanged) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    hintTextColor: ColorConstant.white,
    keyboardType: TextInputType.text,
    prefixIcon: Icons.search,
    prefixIconColor: ColorConstant.white,
    onChanged: onChanged,
  );
}

CommonTextFormField calenderTextFormField(TextEditingController controller,
    String hintText, GestureTapCallback? onTap) {
  return CommonTextFormField(
    controller: controller,
    hintText: hintText,
    prefixIcon: Icons.calendar_today,
    onTap: onTap,
    readOnly: true,
  );
}
