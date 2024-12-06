import 'package:flutter/material.dart';

class SqColors {

  static const List<Color>  bottom_bar_colors =[
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.teal,
    Colors.tealAccent,
  ] ;

  static  Color primary_YESD =  hexColor(0XFF4A4266);
  static const Color primary_YESSD = Color(0XFFFFC64B);
  static const Color primary =       Color(0xFFF8F8F8);
  static const Color primaryDark =Colors.orange;
  static const Color primarygreen =Colors.green;


  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex,{double alpha = 1}){
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
        (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0,
        alpha);
  }
}
