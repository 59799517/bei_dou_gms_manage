import 'dart:convert';

import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/entity/GameConfigEntity.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class ConfigLogic extends GetxController {

  String V_dropdown_main_view = "dropdown_main_view";
  String V_dropdown_sub_view = "dropdown_sub_view";
  String V_show_doby_view = "show_doby_view";


  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 10;

//选择的值
  String dropdownValue = "全部";
  String dropdownValueSub = "全部";
  String searchValue = "";

List<GameConfigEntity> list = [];
Map<String, String> typeMap = {};
Map<String, String> subTypeMap = {};
//获取data数据
getConfigList({bool clear=false}) async{
  if(clear){
    pageNo = 1;
    list.clear();
    total= 0;
  }
  Map<String, dynamic> params = {"type":typeMap[dropdownValue],"subType":subTypeMap[dropdownValueSub],"filter":searchValue,"pageNo":pageNo,"pageSize":pageSize};
   var value = await accountApi.getConfigList(params);
  if(value["code"] == 20000){
    list.addAll(GameConfigEntity.fromList(value["data"]['records']));
    total = value["data"]['totalRow'];
    update([V_show_doby_view]);
  }

}


  //获取设置类型列表
  Future getSettingTypeList() async {
   var result = await accountApi.getConfigTypeList();
    if(result['code']==20000){
      // result 转map
    var  type = result["data"]["types"];
     typeMap["全部"]="";
     type.forEach((element) {
       if(element=="world"){
         typeMap["大区"] = element;
       }else if(element=="server"){
         typeMap["全局"] = "server";
       }else{
         typeMap[element] = element;
       }
     });
    subTypeMap["全部"]="";
    result["data"]["subTypes"].forEach((element) {
         if(element=="Core"){
           subTypeMap["核心"] = element;
         }else if(element=="Game Mechanics"){
           subTypeMap["游戏机制"] = element;
         } else if(element=="Safe"){
           subTypeMap["安全"] = element;
         }else if(element=="Net"){
           subTypeMap["网络"] = element;
         }else if(element=="Debug"){
           subTypeMap["调试"] = element;
         } else if(element=="GM"){
           subTypeMap["GM"] = element;
         }else{
           subTypeMap["大区"+element] = element;
         }
      });
     dropdownValueSub = subTypeMap.keys.first;
    }
    update([V_dropdown_main_view]);
  }
  //删除设置数据
  Future deleteConfigData(String id) async {
  List<dynamic> ids = [];
  ids.add(id);
    var value = await accountApi.deleteConfigData(ids);
    if (value["code"] == 20000) {
      BotToast.showText(text: "删除成功");
    } else {
      BotToast.showText(text: "删除失败");
    }
  }




  /// java类型转换字符串
  String ConfigClazzToString(String configClazz) {
    if (configClazz == "java.lang.Integer") {
      return "整数";
    } else if (configClazz == "java.lang.String") {
      return "字符串";
    } else if (configClazz == "java.lang.Boolean") {
      return "布尔";
    } else if (configClazz == "java.lang.Float") {
      return "小数";
    } else if (configClazz == "java.lang.Long") {
      return "长整数";
    } else if (configClazz == "java.lang.Double") {
      return "双精度";
    } else if (configClazz == "java.lang.Byte") {
      return "字节";
    } else if (configClazz == "java.lang.Short") {
      return "短整数";
    } else if (configClazz == "java.lang.Character") {
      return "字符";
    } else if (configClazz == "java.lang.Object") {
      return "对象";
    } else if (configClazz == "java.lang.Date") {
      return "日期";
    }else if (configClazz == "java.util.Map") {
      return "Map";
    } else {
      return "未知类型";
    }
  }
  /// java类型转换WidgetType
  WidgetType ConfigClazzToWidgetType(String configClazz) {
    if (configClazz == "java.lang.Integer") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.String") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Boolean") {
      return WidgetType.toggle;
    } else if (configClazz == "java.lang.Float") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Long") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Double") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Byte") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Short") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Character") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Object") {
      return WidgetType.input;
    } else if (configClazz == "java.lang.Date") {
      return WidgetType.date;
    } else {
      return WidgetType.input;
    }
  }
  /// java类型转换InputType
  InputType  ConfigClazzToInputType(WidgetType type, String configClazz) {
    if (type == WidgetType.input) {
      if (configClazz == "java.lang.Integer") {
        return InputType.number;
      } else if (configClazz == "java.lang.String") {
        return InputType.text;
      } else if (configClazz == "java.lang.Float") {
        return InputType.number;
      } else if (configClazz == "java.lang.Long") {
        return InputType.number;
      } else if (configClazz == "java.lang.Double") {
        return InputType.number;
      } else if (configClazz == "java.lang.Byte") {
        return InputType.number;
      } else if (configClazz == "java.lang.Short") {
        return InputType.number;
      } else if (configClazz == "java.lang.Character") {
        return InputType.text;
      } else {
        return InputType.text;
      }
    } else if (type == WidgetType.date) {
      return InputType.date;
    } else if (type == WidgetType.toggle) {
      return InputType.text;
    } else if (type == WidgetType.sex) {
      return InputType.text;
    } else if (type == WidgetType.slider) {
      return InputType.number;
    } else {
      return InputType.text;
    }
  }
  /// 根据类型字符串转为java类型
  String getConfigClazz(String type) {
    if (type == "整数") {
      return "java.lang.Integer";
    } else if (type == "字符串") {
      return "java.lang.String";
    } else if (type == "布尔") {
      return "java.lang.Boolean";
    } else if (type == "小数") {
      return "java.lang.Float";
    } else if (type == "长整数") {
      return "java.lang.Long";
    } else if (type == "双精度") {
      return "java.lang.Double";
    } else if (type == "字节") {
      return "java.lang.Byte";
    } else if (type == "短整数") {
      return "java.lang.Short";
    } else if (type == "Map") {
      return "java.util.Map";
    }else {
      return "java.lang.String";
    }
  }
  List<String> javaTypeNameList = [
    "整数",
    "字符串",
    "布尔",
    "小数",
    "长整数",
    "双精度",
    "字节",
    "短整数",
    "Map"
  ];


}
