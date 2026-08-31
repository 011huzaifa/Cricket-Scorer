import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:flutter/material.dart';

class Widgets {
  // Score Button
  static Center scoreButton({
    required bool isScoreButton,
    required String buttonLabel,
    required VoidCallback callback,
  }) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: isScoreButton
              ? Appcolors.primaryColor
              : Appcolors.primaryTextColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: callback,
          child: Text(
            buttonLabel,
            style: TextStyle(color: Appcolors.backgroundColor, fontSize: 22),
          ),
        ),
      ),
    );
  }

  //custom button
  static SizedBox customButton({
    required String buttonLabel,
    required VoidCallback callback,
    bool outlined = false,
    bool fullWidth = false,
  }) {
    return SizedBox(
      width: fullWidth ? double.infinity : 150,
      height: 33,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: outlined
              ? Appcolors.backgroundColor
              : Appcolors.primaryColor,
          side: outlined
              ? BorderSide(width: 2, color: Appcolors.primaryColor)
              : BorderSide.none,
          foregroundColor: outlined
              ? Appcolors.primaryColor
              : Appcolors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(buttonLabel),
      ),
    );
  }
}
