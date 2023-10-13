import 'package:flutter/material.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';

class CustomSnackbar {
  static void showSnackbar(BuildContext context, String contentText,
      {String actionText = 'Close', VoidCallback? onPressed}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorResources.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          contentText,
          style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).highlightColor),
        ),
        action: SnackBarAction(
          label: actionText,
          textColor: ColorResources.black,
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }
}
