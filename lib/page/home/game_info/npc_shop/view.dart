import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class NpcShopComponent extends StatefulWidget {
  @override
  State<NpcShopComponent> createState() => _NpcShopComponentState();
}

class _NpcShopComponentState extends State<NpcShopComponent> {
  final Npc_shopLogic logic = Get.put(Npc_shopLogic());

  ScrollController _scrollController = ScrollController();
  TextEditingController _shop_Controller = TextEditingController();
  TextEditingController _npc_id_chController = TextEditingController();
  TextEditingController _npc_name_chController = TextEditingController();
  TextEditingController _good_id_Controller = TextEditingController();
  TextEditingController _goods_name_Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic.reqSearchNpcList(clear: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        logic.pageNo++;
        logic.reqSearchNpcList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<Npc_shopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("NPC商店"),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("商店ID"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _shop_Controller,
                                      decoration: InputDecoration(
                                          hintText: "商店id"),
                                    ),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("NPC ID"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _npc_id_chController,
                                      decoration: InputDecoration(
                                          hintText: "NPC ID"),
                                    ),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("NPC名称"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _npc_name_chController,
                                      decoration: InputDecoration(
                                          hintText: "NPC名称"),
                                    ),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("物品ID"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _good_id_Controller,
                                      decoration: InputDecoration(
                                          hintText: "物品ID"),
                                    ),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("物品名称"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _goods_name_Controller,
                                      decoration: InputDecoration(
                                          hintText: "物品名称"),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ), //确定按钮
                      confirm: TextButton(
                          onPressed: () {
                            logic.shopId = _shop_Controller.text ?? "";
                            logic.npcId = _npc_id_chController.text ?? "";
                            logic.npcName = _npc_name_chController.text ?? "";
                            logic.itemId = _good_id_Controller.text ?? "";
                            logic.itemName = _goods_name_Controller.text ?? "";
                            logic.reqSearchNpcList(clear: true);
                            Get.back();
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))
                              )
                          ),
                          child: const Text("确定")), //取消按钮
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
                body: GetBuilder<Npc_shopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqSearchNpcList(clear: true);
                        },
                        displacement: 40.0, // 下拉距离
                        child: Container(
                          child: ListView.separated(
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
                                            category: "npc",
                                            itemId: logic.npcList[index].npcId,
                                          )),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Symbols
                                                .error_circle_rounded);
                                          }),
                                    ),
                                    title: Text(
                                      "${logic.npcList[index].npcName}(${logic.npcList[index].npcId})",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text("中级", style: TextStyle(color: Colors.white)),

                                    subtitle: Row(
                                      children: <Widget>[
                                        // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                        Text(
                                            "商店ID:${logic.npcList[index].shopId.toString()}")
                                      ],
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        size: 30.0),
                                    onTap: () {
                                      Get.toNamed("/game/npc/info", arguments: {
                                        "data": logic.npcList[index],
                                        "name": logic.npcList[index].npcName,
                                        "id": logic.npcList[index].shopId
                                            .toString()
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.npcList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 1,
                              );
                            },
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
