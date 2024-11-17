import 'package:flutter/material.dart';

class TextFormat {
  static Widget bold({
    required String text,
    TextAlign? textAlign,
    double? opacity,
    Color? textColor,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      
    );
  }

  static Widget small({
    required String text,
    TextAlign? textAlign,
    double? opacity,
    Color? textColor,
    FontWeight? fontWeight,
    void Function()? onTap,
    TextDecoration? decoration,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        
      ),
    );
  }

  static Widget extraSmall({
    required String text,
    TextAlign? textAlign,
    double? opacity,
    Color? textColor,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      
    );
  }
}
