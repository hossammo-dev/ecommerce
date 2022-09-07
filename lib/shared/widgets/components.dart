import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

TextFormField defaultTextField({
  required TextEditingController controller,
  TextInputType? type = TextInputType.text,
  String? hint,
  String? label,
  bool? isPassword = false,
  bool? showPassword = false,
  VoidCallback? changePassVisibility,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: showPassword!,
      validator: (String? value) {
        if (value!.isEmpty) return 'This field is required';
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: (isPassword!)
            ? GestureDetector(
                onTap: changePassVisibility,
                child: Icon((showPassword)
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
              )
            : null,
      ),
    );

MaterialButton defaultButton(
        {required String title, required VoidCallback btnFun}) =>
    MaterialButton(
      onPressed: btnFun,
      color: Colors.teal,
      padding: const EdgeInsets.all(8),
      minWidth: double.infinity,
      height: 48,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

Future<bool?> defaultToast({
  required String message,
  Color? bgColor,
  Color? txColor,
}) =>
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: bgColor,
      fontSize: 18,
      textColor: txColor,
      gravity: ToastGravity.BOTTOM,
    );

void navigateTo(
  BuildContext context, {
  required Widget page,
  PageTransitionType transition = PageTransitionType.leftToRight,
}) =>
    Navigator.of(context).push(PageTransition(child: page, type: transition));

void navigateReplace(
  BuildContext context, {
  required Widget page,
  PageTransitionType transition = PageTransitionType.bottomToTop,
}) =>
    Navigator.of(context)
        .pushReplacement(PageTransition(child: page, type: transition));
