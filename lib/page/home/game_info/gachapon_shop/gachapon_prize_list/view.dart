import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_prize_list/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponPrizeListComponent extends StatefulWidget {
  @override
  State<GachaponPrizeListComponent> createState() =>
      _GachaponPrizeListComponentState();
}

class _GachaponPrizeListComponentState
    extends State<GachaponPrizeListComponent> {
  final GachaponPrizeListLogic logic = Get.put(GachaponPrizeListLogic());
  String appBarName = "奖品列表";
  Map<String, dynamic> data = Get.arguments;

  @override
  void initState() {
    super.initState();
    setState(() {
      appBarName = "${data["name"]}(${data["id"]}) - 奖品列表";
    });
    logic.searchData = data["data"].toJson();
    logic.reqSearchList(clear: true);
  }

  // 2000012
  //{"poolId":10,"quantity":1,"itemId":2000012,"comment":"321"}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<GachaponPrizeListLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                    title: Row(
                      children: [
                        Text(appBarName),
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Get.toNamed("/game/gachapon/prize/add",
                                arguments: {"id": data["id"].toString()});
                          },
                          icon: Icon(Symbols.add_2_rounded))
                    ]),
                body: GetBuilder<GachaponPrizeListLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqSearchList(clear: true);
                        },
                        displacement: 40.0, // 下拉距离
                        child: Container(
                          child: ListView.separated(
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
                                        logic.reqDelete(logic.list[index]).then(
                                            (value) => {
                                                  logic.reqSearchList(
                                                      clear: true)
                                                })
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
                                        Get.toNamed("/game/gachapon/prize/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name":
                                                  logic.list[index].itemName,
                                              "id": logic.list[index].poolId
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
                                              itemId: logic.list[index].itemId,
                                            )),
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Symbols
                                                  .error_circle_rounded);
                                            }),
                                      ),
                                      title: Text(
                                        "${logic.list[index].itemName}(${logic.list[index].itemId})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                          Text(
                                            "数量:${logic.list[index].quantity.toString()}",
                                          )
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        Get.toNamed("/game/gachapon/prize/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name":
                                                  logic.list[index].itemName,
                                              "id": logic.list[index].poolId
                                                  .toString()
                                            });
                                      },
                                      // onLongPress: () {
                                      //   _search_Controller.text =logic.list[index].gachaponId.toString();
                                      //   _showSearchDialog();
                                      // },
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.list.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
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
