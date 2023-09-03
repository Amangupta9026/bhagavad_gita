import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GradientTextView extends StatelessWidget {
  const GradientTextView({Key? key, required this.title, this.selectionGradient, this.textSize = 16, this.textAlign}) : super(key: key);

  final String title;
  final TextAlign? textAlign;
  final List<Color>? selectionGradient;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          const Offset(24.0, 4.0),
          const Offset(4.0, 19.0),
          selectionGradient ?? [] 
          //?? (AppColors.textGradientColorList),
        );
      },
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w600,
         
        ))
      //SemiBoldTextView(data: title, fontSize: textSize),
    );
  }
}
