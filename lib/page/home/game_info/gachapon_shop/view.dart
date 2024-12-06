import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponShopComponent extends StatefulWidget {
  @override
  State<GachaponShopComponent> createState() => _GachaponShopComponentState();
}

class _GachaponShopComponentState extends State<GachaponShopComponent> {
  final GachaponShopLogic logic = Get.put(GachaponShopLogic());

  ScrollController _scrollController = ScrollController();
  TextEditingController _search_Controller = TextEditingController();

  void _showSearchDialog() {
    Get.defaultDialog(
      title: "搜索", // middleText: "您确定要删除吗?",
      content: Container(
        // height: 500,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("百宝箱ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _search_Controller,
                  decoration: InputDecoration(
                      hintText: "百宝箱ID"),
                ),
              )
            ]),
          ],
        ),
      ), //确定按钮
      confirm: TextButton(
          onPressed: () {
            logic.searchValue = _search_Controller.text ?? "";
            logic.reqSearchList(clear: true);
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
  void initState() {
    super.initState();
    logic.reqSearchList(clear: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        logic.pageNo++;
        logic.reqSearchList();
      }
    });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print("didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<GachaponShopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                    title: Row(
                      children: [
                        Text("百宝箱"),
                        IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "提示",
                                  middleText: "长按列表快捷搜索物",
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
                              "/game/gachapon/add",
                            );
                          },
                          icon: Icon(Symbols.add_2_rounded))
                    ]),
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
                body: GetBuilder<GachaponShopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.reqSearchList(clear: true);
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
                                        Get.toNamed("/game/gachapon/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name": logic
                                                  .list[index].gachaponName,
                                              "id": logic.list[index].id
                                                  .toString(),
                                              "gachaponId": logic
                                                  .list[index].gachaponId
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
                                              category: "npc",
                                              itemId:
                                                  logic.list[index].gachaponId,
                                            )),
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Symbols
                                                  .error_circle_rounded);
                                            }),
                                      ),
                                      title: Text(
                                        "${logic.list[index].gachaponName}(${logic.list[index].gachaponId})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                          Text(
                                            "名称:${logic.list[index].name.toString()}",
                                          )
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        Get.toNamed("/game/gachapon/prize",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name": logic
                                                  .list[index].gachaponName,
                                              "id": logic.list[index].id
                                                  .toString(),
                                              "gachaponId": logic
                                                  .list[index].gachaponId
                                                  .toString()
                                            });
                                      },
                                      onLongPress: () {
                                        _search_Controller.text = logic
                                            .list[index].gachaponId
                                            .toString();
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
