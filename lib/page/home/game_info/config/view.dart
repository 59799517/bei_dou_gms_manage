import 'package:bei_dou_gms_manage/page/home/game_info/config/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class ConfigComponent extends StatefulWidget {
  @override
  State<ConfigComponent> createState() => _ConfigComponentState();
}

class _ConfigComponentState extends State<ConfigComponent> {
  final ConfigLogic logic = Get.put(ConfigLogic());
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //监听 _scrollController
    logic
        .getSettingTypeList()
        .then((value) => {logic.getConfigList(clear: true)});
    _scrollController.addListener(() {
      //判断是否滑到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //加载更多
        logic.pageNo++;
        logic.getConfigList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<ConfigLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("参数设置"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.toNamed(
                            "/game/config/add",
                          );
                        },
                        icon: Icon(Symbols.add_2_rounded))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "搜索",
                      content: Container(
                        // height: 500,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("参数大类"),
                                GetBuilder<ConfigLogic>(
                                    id: logic.V_dropdown_main_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.dropdownValue.isEmpty
                                            ? null
                                            : logic.dropdownValue,
                                        hint: Text("请选择分类"),
                                        items: logic.typeMap.keys.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            logic.dropdownValue = value!;
                                            logic.update(
                                                [logic.V_dropdown_main_view]);
                                          });
                                        },
                                      );
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("参数分类"),
                                GetBuilder<ConfigLogic>(
                                    id: logic.V_dropdown_sub_view,
                                    builder: (logic) {
                                      return DropdownButton<String>(
                                        value: logic.dropdownValueSub.isEmpty
                                            ? null
                                            : logic.dropdownValueSub,
                                        hint: Text("请选择类型"),
                                        items: logic.subTypeMap.keys.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            logic.dropdownValueSub = value!;
                                            logic.update(
                                                [logic.V_dropdown_sub_view]);
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
                                  Text("搜索文本"),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                          hintText: "请输入搜索文本"),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ), //确定按钮
                      confirm: TextButton(
                          onPressed: () {
                            //单击后删除弹框
                            logic.searchValue = _searchController.text ?? "";
                            logic.getConfigList(clear: true);
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
                body: GetBuilder<ConfigLogic>(
                    id: logic.V_show_doby_view,
                    builder: (logic) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          logic.getConfigList(clear: true);
                        },
                        displacement: 40.0, // 下拉距离
                        child: Container(
                          child: ListView.builder(
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
                                            .deleteConfigData(
                                                logic.list[index].id.toString())
                                            .then((value) => {
                                                  logic.getConfigList(
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
                                        Get.toNamed("/game/config/edit",
                                            arguments: {
                                              "data": logic.list[index],
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
                                      title: Text(
                                        "当前值：${logic.list[index].configValue}",
                                        overflow:
                                            TextOverflow.ellipsis, //长度溢出后显示省略号
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        logic.list[index].configDesc,
                                        overflow:
                                            TextOverflow.ellipsis, //长度溢出后显示省略号
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_right,
                                          size: 30.0),
                                      onTap: () {
                                        Get.toNamed("/game/config/edit",
                                            arguments: {
                                              "data": logic.list[index],
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: logic.list.length,
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
