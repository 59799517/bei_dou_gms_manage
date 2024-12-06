import 'package:bei_dou_gms_manage/api/page/AccountApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/config/logic.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class ConfigAddLogic extends GetxController {

  final ConfigLogic configlogic = Get.put(ConfigLogic());


  String V_list_body_view = "list_body_view";
  String V_dropdown_main_view = "dropdown_main_view";
  String V_dropdown_sub_view = "dropdown_sub_view";
  String V_dropdown_configClazzStr_view = "dropdown_configClazzStr_view";

//选择的值
  String dropdownValue = "";
  String dropdownValueSub = "";
  String configClazzStr = "字符串";

  Map<String, String> typeMap = {};
  Map<String, String> subTypeMap = {};

  //获取设置类型列表
  Future getSettingTypeList() async {
    var result = await accountApi.getConfigTypeList();
    if(result['code']==20000){
      // result 转map
      var  type = result["data"]["types"];
      type.forEach((element) {
        if(element=="world"){
          typeMap["大区"] = element;
        }else if(element=="server"){
          typeMap["全局"] = "server";
        }else{
          typeMap[element] = element;
        }
      });
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
      dropdownValue = typeMap.keys.first;
    }
    update([V_dropdown_main_view,V_dropdown_sub_view,V_dropdown_configClazzStr_view,V_list_body_view]);
  }

  //新增参数
  Future addConfig( Map<String, dynamic> data) async {
    //参数校验
    if(configClazzStr.isEmpty){
      BotToast.showText(text: "请输入参数名称");
      return;
    }
    if(data["configCode"].toString().isEmpty){
      BotToast.showText(text: "请输入参数名称");
      return;
    }
    if(data["configValue"].toString().isEmpty){
      BotToast.showText(text: "请输入参数值");
      return;
    }
    if(dropdownValue.isEmpty){
      BotToast.showText(text: "请选择参数大类");
      return;
    }
    if(dropdownValueSub.isEmpty){
      BotToast.showText(text: "请选择参数小类");
      return;
    }
    String configClazz = configlogic.getConfigClazz(configClazzStr);
    //校验都通过组装信息
    Map<String, dynamic> p = {"configType":typeMap[dropdownValue],"configSubType": subTypeMap[dropdownValueSub],"configClazz":configClazz,"configCode":data["configCode"],"configValue":data["configValue"],"configDesc":data["configDesc"]};
    var value = await accountApi.addConfigData(p);
    if (value["code"] == 20000) {
      BotToast.showText(text: "新增成功！");
    } else {
      BotToast.showText(text: "新增失败！");
    }
  }

}
