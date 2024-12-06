import 'package:bei_dou_gms_manage/page/home/game_info/monster_shiop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class MonsterShiopComponent extends StatefulWidget {
  @override
  State<MonsterShiopComponent> createState() => _MonsterShiopComponentState();
}

class _MonsterShiopComponentState extends State<MonsterShiopComponent> {
  final MonsterShiopLogic logic = Get.put(MonsterShiopLogic());
  ScrollController _scrollController = ScrollController();
  TextEditingController _dropperId_Controller = TextEditingController();
  TextEditingController _itemId_chController = TextEditingController();
  TextEditingController _questId_chController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic.reqSearcMonsterList(clear: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        logic.pageNo++;
        logic.reqSearcMonsterList();
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
              Text("怪物ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _dropperId_Controller,
                  decoration: InputDecoration(
                      hintText: "怪物ID"),
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
            //搜索框值
            logic.dropperId = _dropperId_Controller.text ?? "";
            logic.itemId = _itemId_chController.text ?? "";
            logic.questId = _questId_chController.text ?? "";
            logic.reqSearcMonsterList(clear: true);
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

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).textTheme.titleLarge!.color!;

    return DefaultTabController(
      length: 5,
      child: GetBuilder<MonsterShiopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      Text("怪物爆率"),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "提示",
                                middleText: "长按列表快捷搜索怪物和物品",
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
                  ), //尾部增加一个按钮
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.toNamed(
                            "/game/monster/add",
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
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                body: GetBuilder<MonsterShiopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqSearcMonsterList(clear: true);
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
                                            .reqDeleteMonster(logic
                                                .monsterList[index].id
                                                .toString())
                                            .then((value) => {
                                                  logic.reqSearcMonsterList(
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
                                        Get.toNamed("/game/monster/edit",
                                            arguments: {
                                              "data": logic.monsterList[index],
                                              "name": logic.monsterList[index]
                                                  .dropperName,
                                              "id": logic
                                                  .monsterList[index].dropperId
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      leading: Container(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.white12))),
                                        child:
                                            logic.monsterList[index].itemId == 0
                                                ? Image(
                                                    image: NetworkImage(
                                                        "https://maplestory.io/api/GMS/83/item/5200002/icon"),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Icon(Symbols
                                                          .error_circle_rounded);
                                                    },
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image(
                                                    image: NetworkImage(
                                                        MSImageUtils.getIconUrl(
                                                      category: "item",
                                                      itemId: logic
                                                          .monsterList[index]
                                                          .itemId,
                                                    )),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(Symbols
                                                          .error_circle_rounded);
                                                    }),
                                      ),
                                      title: Text(
                                        "${logic.monsterList[index].itemId == 0 ? "金币" : logic.monsterList[index].itemName}",
                                        style: TextStyle(
                                            color: logic.monsterList[index]
                                                        .itemId ==
                                                    0
                                                ? Colors.yellowAccent
                                                : primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                          Text(
                                              "怪物:${logic.monsterList[index].dropperName.toString()}")
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onLongPress: () {
                                        _itemId_chController.text = logic
                                            .monsterList[index].itemId
                                            .toString();
                                        _dropperId_Controller.text = logic
                                            .monsterList[index].dropperId
                                            .toString();
                                        _showSearchDialog();
                                      },
                                      onTap: () {
                                        Get.toNamed("/game/monster/edit",
                                            arguments: {
                                              "data": logic.monsterList[index],
                                              "name": logic.monsterList[index]
                                                  .dropperName,
                                              "id": logic
                                                  .monsterList[index].dropperId
                                                  .toString()
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.monsterList.length,
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
