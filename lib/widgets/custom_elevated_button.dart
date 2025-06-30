import 'package:contacts_app/core/app_color.dart';
import 'package:contacts_app/core/app_style.dart';
import 'package:flutter/material.dart';

typedef ButtonCallback = void Function();

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final ButtonCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.gold, 
          foregroundColor: AppColor.darkBlue, 
          overlayColor: AppColor.transparentColor,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppStyle.titleLarge
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}