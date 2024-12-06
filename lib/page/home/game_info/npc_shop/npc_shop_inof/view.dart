import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/entity/NPCEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/npc_shop/npc_shop_inof/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class NpcShopInofComponent extends StatefulWidget {
  @override
  State<NpcShopInofComponent> createState() => _NpcShopInofComponentState();
}

class _NpcShopInofComponentState extends State<NpcShopInofComponent> {
  final NpcShopInofLogic logic = Get.put(NpcShopInofLogic());
  ScrollController _scrollController = ScrollController();
  final Map<String, dynamic> data = Get.arguments;

  String appbarName = "";

  @override
  void initState() {
    logic.shopId = data["data"]!.shopId.toString();
    appbarName = data["name"].toString();
    super.initState();
    logic.reqSearchNpcInfoList(clear: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        logic.pageNo++;
        logic.reqSearchNpcInfoList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<NpcShopInofLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(appbarName),
                  actions: [
                    IconButton(
                      icon: Icon(Symbols.add),
                      onPressed: () {
                        Get.toNamed("/game/npc/info/add",
                            arguments: {"shopId": data["id"]});
                      },
                    )
                  ],
                ),
                body: GetBuilder<NpcShopInofLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqSearchNpcInfoList(clear: true);
                        },
                        displacement: 40.0, // 下拉距离
                        child: Container(
                          child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              return Slidable(
                                direction: Axis.horizontal,
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      spacing: 5,
                                      onPressed: (value) => {
                                        logic.deleteNpcInfo(
                                            logic.npcList[index].id.toString()),
                                        logic.reqSearchNpcInfoList(clear: true),
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: '删除',
                                    ),
                                    SlidableAction(
                                      flex: 1,
                                      spacing: 5,
                                      onPressed: (value) => {
                                        //进入编辑界面
                                        Get.toNamed("/game/npc/info/edit",
                                            arguments: {
                                              "data": logic.npcList[index],
                                              "name":
                                                  logic.npcList[index].itemName,
                                              "id": logic.npcList[index].shopId
                                                  .toString()
                                            })
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: '编辑',
                                    ),
                                  ],
                                ),
                                child: Card(
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
                                              itemId:
                                                  logic.npcList[index].itemId,
                                            )),
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Symbols
                                                  .error_circle_rounded);
                                            }),
                                      ),
                                      title: Text(
                                        "${logic.npcList[index].itemName}(${logic.npcList[index].itemId})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: Text("中级", style: TextStyle(color: Colors.white)),

                                      subtitle: Row(
                                        children: <Widget>[
                                          // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                          Text(
                                              "价格:${logic.npcList[index].price.toString()}")
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        //进入编辑界面
                                        Get.toNamed("/game/npc/info/edit",
                                            arguments: {
                                              "data": logic.npcList[index],
                                              "name":
                                                  logic.npcList[index].itemName,
                                              "id": logic.npcList[index].shopId
                                                  .toString()
                                            });
                                      },
                                    ),
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
