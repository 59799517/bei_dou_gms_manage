import 'package:bei_dou_gms_manage/page/home/bar_home/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/cash_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

class CashShopComponent extends StatefulWidget {
  @override
  State<CashShopComponent> createState() => _CashShopComponentState();
}

class _CashShopComponentState extends State<CashShopComponent>
    with SingleTickerProviderStateMixin {
  final CashShopLogic logic = Get.put(CashShopLogic());
  final BarHomeLogic barLogic = Get.put(BarHomeLogic());
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic.getCashShopType().then(
          (value) => {logic.reqgetCommodityByCategory(clear: true)},
        );
    //监听 _scrollController
    _scrollController.addListener(() {
      //判断是否滑到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //加载更多
        logic.pageNo++;
        logic.reqgetCommodityByCategory();
      }
    });
  }

  // void init() async {
  //   logic.getCashShopType();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<CashShopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("商城管理"),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "搜索", // middleText: "您确定要删除吗?",
                      content: Container(
                        // height: 500,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("类型"),
                                GetBuilder<CashShopLogic>(
                                    id: logic.V_dropdown_main_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.select_name.isEmpty
                                            ? null
                                            : logic.select_name,
                                        hint: Text("请选择类型"),
                                        items: logic.data.keys.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            logic.select_name = value!;
                                            logic.select_sub_name =
                                                logic.data[value]![0].subName;
                                            logic.getSubDropdownMenuItem(
                                                logic.select_name);
                                            logic.update([
                                              logic.V_dropdown_sub_view,
                                              logic.V_dropdown_main_view
                                            ]);
                                          });
                                        },
                                      );
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("子类型"),
                                GetBuilder<CashShopLogic>(
                                    id: logic.V_dropdown_sub_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.select_sub_name.isEmpty
                                            ? null
                                            : logic.select_sub_name,
                                        hint: Text("请选择子类型"),
                                        items: logic
                                            .getSubDropdownMenuItem(
                                                logic.select_name)
                                            .map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            // logic.select_name= value!;
                                            logic.select_sub_name = value!;
                                          });
                                        },
                                      );
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("状态"),
                                GetBuilder<CashShopLogic>(
                                    id: logic.V_dropdown_status_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.select_status_name.isEmpty
                                            ? null
                                            : logic.select_status_name,
                                        hint: Text("请选择状态"),
                                        items: logic.statusList.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            logic.select_status_name = value!;
                                            logic.update(
                                                [logic.V_dropdown_status_view]);
                                          });
                                        },
                                      );
                                    })
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("物品ID"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                          hintText: "请输入物品ID",
                                         ),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ), //确定按钮
                      confirm: TextButton(
                          onPressed: () {
                            //单击后删除弹框
                            logic.search_value = _searchController.text ?? "";
                            logic.reqgetCommodityByCategory(clear: true);
                            Get.back();
                          },
                          //块状按钮
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))
                              )
                          ),

                          child: const Text("确定")),
                      //取消按钮
                      cancel: TextButton(
                          onPressed: () {
                            //单击后删除弹框
                            Get.back();
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))
                              )
                          ),
                          child: const Text("取消")),
                    );
                  },
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.transparent, width: 1.0)),

                  ///长按提示
                  tooltip: "没啥东西小彩蛋",

                  ///设置悬浮按钮的背景
                  backgroundColor: Colors.orange,

                  ///获取焦点时显示的颜色
                  focusColor: Colors.orange,

                  ///鼠标悬浮在按钮上时显示的颜色
                  hoverColor: Colors.orange,

                  ///水波纹颜色
                  splashColor: Colors.orangeAccent,

                  ///定义前景色 主要影响文字的颜色
                  foregroundColor: Colors.orange,

                  ///配制阴影高度 未点击时
                  elevation: 0.0,

                  ///配制阴影高度 点击时
                  highlightElevation: 50.0,
                  child: Container(
                    child: const Icon(
                      Symbols.search,
                      color: Colors.white,
                    ),
                  ),
                ),

                ///用来控制  FloatingActionButton 的位置
                ///FloatingActionButtonLocation.endFloat 默认使用 浮动右下角
                ///FloatingActionButtonLocation.endDocked 右下角
                ///FloatingActionButtonLocation.endTop  右上角
                ///FloatingActionButtonLocation.startTop 左上角
                ///FloatingActionButtonLocation.centerFloat 底部中间浮动
                ///FloatingActionButtonLocation.centerDocked 底部中间不浮动
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                body: GetBuilder<CashShopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqgetCommodityByCategory(clear: true);
                        },
                        displacement: 40.0, // 下拉距离
                        child: Container(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 8.0,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                child: Container(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white12))),
                                      child: Image(
                                          image: NetworkImage(
                                              MSImageUtils.getIconUrl(
                                            category: "item",
                                            itemId: logic
                                                .cashShopInfoList[index].itemId,
                                          )),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Symbols
                                                .error_circle_rounded);
                                          }),
                                    ),
                                    title: Text(
                                      "${logic.cashShopInfoList[index].itemName}(${logic.cashShopInfoList[index].itemId})",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text("中级", style: TextStyle(color: Colors.white)),

                                    subtitle: Row(
                                      children: <Widget>[
                                        // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                        Text(
                                          "sn:${logic.cashShopInfoList[index].sn.toString()}",
                                        )
                                      ],
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        size: 30.0),
                                    onTap: () {
                                      Get.toNamed("/game/cashshop/info",
                                          arguments: {
                                            "data":
                                                logic.cashShopInfoList[index],
                                          });
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.cashShopInfoList.length,
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
