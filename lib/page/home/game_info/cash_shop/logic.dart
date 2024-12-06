import 'package:bei_dou_gms_manage/api/page/CashShopApi.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/cash_shop_info/CashShopInfoEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/cash_shop_info/CategoryTypeResult.dart';
import 'package:get/get.dart';

class CashShopLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  //页面模块名称
  String V_dropdown_sub_view = "dropdown_sub_view";
  String V_dropdown_main_view = "dropdown_main_view";
  String V_dropdown_status_view = "dropdown_status_view";
  String V_show_doby_view = "show_doby_view";

  List<String> statusList = ["全部", "上架中", "待售"];
  Map<String, String> statusMap = {"全部": "null", "上架中": "1", "待售": "0"};

  String select_name = "热卖";

  String select_sub_name = "新品";

  String select_status_name = "全部";

  String search_value = "";

  //菜单原始数据
  Map<String, List<CategoryTypeResult>> data = {};

  //页码
  int pageNo = 1;

  //总条数接口返回判断最后一页用
  int total = 0;

  //每页条数 接口返回判断最后一页用
  int pageSize = 10;

  List<CashShopInfoEntity> cashShopInfoList = [];

  reqgetCommodityByCategory({bool clear = false}) async {
    if (clear) {
      pageNo = 1;
      cashShopInfoList.clear();
    }
    List<CategoryTypeResult> ids = data[select_name]!;
    CategoryTypeResult sub =
        ids.firstWhere((element) => element.subName == select_sub_name);
    print(
        "name:${sub.name} id:${sub.id} subname:${sub.subName} sunid:${sub.subId}");
    Map<String, dynamic> reqpar = {
      "id": sub.id,
      "subId": sub.subId,
      "pageNo": pageNo
    };
    if (select_status_name != "全部") {
      reqpar["onSale"] = statusMap[select_status_name];
    }
    if (search_value.isNotEmpty) {
      reqpar["itemId"] = search_value;
    }
    var value = await cashShopApi.getCashShopInfo(reqpar);
    if (value["code"] == 20000) {
      cashShopInfoList
          .addAll(CashShopInfoEntity.fromJsonList(value["data"]['records']));
      total = value["data"]['totalRow'];
      pageSize = value["data"]['pageSize'];
      update([V_show_doby_view]);
    }
  }

  //获取二级子菜单
  List<String> getSubDropdownMenuItem(String itemName) {
    //主的名称
    List<CategoryTypeResult> subItemList = data[itemName] ?? [];
    return subItemList.map((e) => e.subName).toList();
  }

  //获取类型
  Future getCashShopType() async {
    var value = await cashShopApi.getCashShopType();
    if (value["code"] == 20000) {
      List<CategoryTypeResult> fromJsonList =
          CategoryTypeResult.fromJsonList(value["data"]);
      //根据ID分组到map key是id，value是list
      data = {};
      for (var item in fromJsonList) {
        if (data.containsKey("${item.name}")) {
          data["${item.name}"]?.add(item);
        } else {
          data["${item.name}"] = [item];
        }
      }
    }
    //给出默认值
    select_name = data.keys.first;
    select_sub_name = data[data.keys.first]![0].subName;
    reqgetCommodityByCategory();
    update([V_dropdown_main_view, V_dropdown_sub_view]);
  }
}
