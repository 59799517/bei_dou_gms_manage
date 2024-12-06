import 'package:bei_dou_gms_manage/storage/DBStorage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeIogic extends GetxController  {
  String THEME_VIEW = "theme_view";

  var light = FlexThemeData.light(scheme: FlexScheme.blue, useMaterial3: true);
  var dark = FlexThemeData.dark(scheme: FlexScheme.blue, useMaterial3: true);
  var system = ThemeMode.system;
  var select_theme  = ThemeMode.system;

  onThemeChanged(String theme){
    if(theme == "dark"){
      select_theme = ThemeMode.dark;
      BDStorage().setThemeConfig("dark");
    }else if(theme == "light"){
      select_theme = ThemeMode.light;
      BDStorage().setThemeConfig("light");
    }else{
      select_theme = system;
      BDStorage().setThemeConfig("auto");
    }
  update([THEME_VIEW]);
  }
  get currentTheme => select_theme;
}
