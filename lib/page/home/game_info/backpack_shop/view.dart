import 'package:bei_dou_gms_manage/page/home/game_info/backpack_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class BackpackShopComponent extends StatefulWidget {
  @override
  State<BackpackShopComponent> createState() => _BackpackShopComponentState();
}

class _BackpackShopComponentState extends State<BackpackShopComponent> {
  final BackpackShopLogic logic = Get.put(BackpackShopLogic());
  ScrollController _scrollController = ScrollController();

  final TextEditingController _dropdownSearchFieldController =
      TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  String? _selectedFruit;

  @override
  void initState() {
    super.initState();
    logic.getTypeList();
    //监听 _scrollController
    _scrollController.addListener(() {
      //判断是否滑到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //加载更多
        logic.pageNo++;
        logic.getDataList();
      }
    });
  }

  //下拉异步数据源
  Future<List<Map<String, String>>> getSuggestions(String query) async {
    List<Map<String, String>> map = await logic.getUserList(query);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<BackpackShopLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("背包管理"),
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
                                GetBuilder<BackpackShopLogic>(
                                    id: logic.V_dropdown_main_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.select_name.isEmpty
                                            ? null
                                            : logic.select_name,
                                        hint: Text("请选择类型"),
                                        items: logic.typeList.keys.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            logic.select_name = value!;
                                            logic.inventoryType = logic
                                                .typeList[value]!
                                                .toString();
                                            logic.update(
                                                [logic.V_dropdown_main_view]);
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
                                  Text("玩家"),
                                  Container(
                                    width: 200, // height: 50,
                                    child: DropDownSearchFormField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller:
                                            _dropdownSearchFieldController,
                                        // onChanged: (String value) {
                                        //   print("onChanged:"+value);
                                        // }
                                      ),
                                      suggestionsCallback: (pattern) {
                                        print("suggestionsCallback:" + pattern);
                                        return getSuggestions(pattern);
                                      },
                                      itemBuilder: (context,
                                          Map<String, String> suggestion) {
                                        return SQListTile(
                                          titleText:
                                              "用户名：${suggestion["name"].toString()}",
                                          subTitleText:
                                              "ID:${suggestion["id"].toString()}",
                                        );
                                      },
                                      itemSeparatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      transitionBuilder: (context,
                                          suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected:
                                          (Map<String, String> suggestion) {
                                        logic.characterId =
                                            suggestion["id"].toString();
                                        _dropdownSearchFieldController.text =
                                            suggestion["name"].toString();
                                      },
                                      suggestionsBoxController:
                                          suggestionBoxController,
                                      validator: (value) =>
                                          value!.isEmpty ? '请输入ID或者名称' : null,
                                      onSaved: (value) =>
                                          {_selectedFruit = value},
                                      displayAllSuggestionWhenTap: false,
                                      noItemsFoundBuilder: (context) {
                                        return Container(
                                          height: 100,
                                          child: Center(
                                            child: Text("没有找到数据"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ), //确定按钮
                      confirm: TextButton(
                          onPressed: () {
                            //单击后删除弹框
                            logic.getDataList(clear: true);

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
                body: GetBuilder<BackpackShopLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.getDataList(clear: true);
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
                                                logic.data[index].toJson())
                                            .then((value) => {
                                                  logic.getDataList(clear: true)
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
                                        if (logic.data[index].equipment)
                                          {
                                            //是装备类型的修改
                                            print("是装备类型的修改"),
                                            Get.toNamed(
                                                "/game/backpack/edit/equip",
                                                arguments: {
                                                  "data": logic.data[index]
                                                      .inventoryEquipment,
                                                  "src": logic.data[index],
                                                  "iteamID":
                                                      logic.data[index].itemId,
                                                })
                                          }
                                        else
                                          {
                                            //不是装备类型的修改
                                            print("不是装备类型的修改"),
                                            Get.toNamed(
                                                "/game/backpack/edit/notequip",
                                                arguments: {
                                                  "data": logic.data[index],
                                                })
                                          }
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
                                            image: NetworkImage(MSImageUtils
                                                .getIconUrlofIteamString(
                                              category: "item",
                                              itemId: logic.data[index].itemId
                                                  .toString(),
                                            )),
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Symbols
                                                  .error_circle_rounded);
                                            }),
                                      ),
                                      title: Text(
                                        "${logic.data[index].itemName}(${logic.data[index].itemId})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: Text("中级", style: TextStyle(color: Colors.white)),

                                      subtitle: Row(
                                        children: <Widget>[
                                          // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                          Text(
                                            "位置:${logic.data[index].position.toString()}(${logic.data[index].quantity.toString()}个)",
                                          )
                                        ],
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        if (logic.data[index].equipment) {
                                          //是装备类型的修改
                                          print("是装备类型的修改");
                                          Get.toNamed(
                                              "/game/backpack/edit/equip",
                                              arguments: {
                                                "data": logic.data[index]
                                                    .inventoryEquipment,
                                                "src": logic.data[index],
                                                "iteamID":
                                                    logic.data[index].itemId,
                                              });
                                        } else {
                                          //不是装备类型的修改
                                          print("不是装备类型的修改");
                                          Get.toNamed(
                                              "/game/backpack/edit/notequip",
                                              arguments: {
                                                "data": logic.data[index],
                                              });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.data.length,
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
