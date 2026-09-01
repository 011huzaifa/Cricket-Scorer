import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:flutter/material.dart';

class InningsOverDialog {
  static void customDialog(
    BuildContext context, {
    required String titlez,
    required String content,
    required VoidCallback callback,
  }) {
    showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(titlez),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                callback();
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Appcolors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
