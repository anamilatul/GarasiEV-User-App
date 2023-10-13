import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import '../../../../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  final bool isBuy;
  final bool isBorder;
  final Color? backgroundColor;
  final double? radius;
  const CustomButton(
      {Key? key,
      this.onTap,
      required this.buttonText,
      this.isBuy = false,
      this.isBorder = false,
      this.backgroundColor,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBuy
              ? ColorResources.white
              : (backgroundColor ?? ColorResources.primaryMaterial),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(
            radius != null ? radius! : (isBorder ? 25 : 25),
          ),
          border: isBuy
              ? Border.all(
                  color: ColorResources.primaryMaterial,
                )
              : null,
        ),
        child: Text(
          buttonText!,
          style: TextStyle(
            fontSize: 16,
            color: isBuy
                ? ColorResources.primaryMaterial
                : Theme.of(context).highlightColor,
          ),
        ),
      ),
    );
  }
}
