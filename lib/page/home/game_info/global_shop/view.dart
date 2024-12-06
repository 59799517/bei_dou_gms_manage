import 'package:bei_dou_gms_manage/page/home/game_info/global_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class GlobalShopComponent extends StatefulWidget {
  @override
  State<GlobalShopComponent> createState() => _GlobalShopComponentState();
}

class _GlobalShopComponentState extends State<GlobalShopComponent> {
  final GlobalShopLogic logic = Get.put(GlobalShopLogic());

  ScrollController _scrollController = ScrollController();
  TextEditingController _continent_Controller = TextEditingController();
  TextEditingController _itemId_chController = TextEditingController();
  TextEditingController _questId_chController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic.getData(clear: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        logic.pageNo++;
        logic.getData();
      }
    });
  }

  void _showSearchDialog() {
    Get.defaultDialog(
      title: "搜索", // middleText: "您确定要删除吗?",
      content: Container(
        // height: 500,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("地区ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _continent_Controller,
                  decoration: InputDecoration(
                      hintText: "地区ID"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("物品ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _itemId_chController,
                  decoration: InputDecoration(
                      hintText: "物品ID"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("任务ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _questId_chController,
                  decoration: InputDecoration(
                      hintText: "任务ID"),
                ),
              )
            ]),
          ],
        ),
      ), //确定按钮
      confirm: TextButton(
          onPressed: () {
            logic.continent = _continent_Controller.text ?? "";
            logic.itemId = _itemId_chController.text ?? "";
            logic.questId = _questId_chController.text ?? "";
            logic.getData(clear: true);
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
  }

  // 1702191

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<GlobalShopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      Text("全局爆率"),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "提示",
                                middleText: "长按列表快捷搜索物品",
                                confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("确定"),
                                ));
                          },
                          icon: Icon(
                            Symbols.error_circle_rounded,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.toNamed(
                            "/game/global/add",
                          );
                        },
                        icon: Icon(Symbols.add_2_rounded))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _showSearchDialog();
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
                body: GetBuilder<GlobalShopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.getData(clear: true);
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
                                        logic
                                            .reqDelete(
                                                logic.list[index].id.toString())
                                            .then((value) => {
                                                  logic
                                                      .getData(clear: true)
                                                      .then((val) => {
                                                            logic.update([
                                                              logic
                                                                  .V_show_doby_view
                                                            ])
                                                          })
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
                                        Get.toNamed("/game/global/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name":
                                                  logic.list[index].itemName,
                                              "id": logic.list[index].itemId
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
                                            "地区ID:${logic.list[index].continent.toString()}",
                                          )
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        Get.toNamed("/game/global/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name":
                                                  logic.list[index].itemName,
                                              "id": logic.list[index].itemId
                                                  .toString()
                                            });
                                      },
                                      onLongPress: () {
                                        _itemId_chController.text =
                                            logic.list[index].itemId.toString();
                                        _showSearchDialog();
                                      },
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
