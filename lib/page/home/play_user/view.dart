import 'package:bei_dou_gms_manage/page/home/play_user/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class PlayUserComponent extends StatefulWidget {
  @override
  State<PlayUserComponent> createState() => _PlayUserComponentState();
}

class _PlayUserComponentState extends State<PlayUserComponent> {
  final PlayUserLogic logic = Get.put(PlayUserLogic());
  ScrollController _scrollController = ScrollController();

  final TextEditingController _id_Controller = TextEditingController();
  final TextEditingController _name_Controller = TextEditingController();
  final TextEditingController _map_id_Controller = TextEditingController();

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
              Text("ID"),
              Container(
                width: 150,
                height: 30,
                child: TextField(
                  cursorColor: Colors.green,
                  controller: _id_Controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                    hintText: "ID",
                    border: OutlineInputBorder(
                      //去掉边框
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide.none,
                      //添加背景颜色
                    ),
                    //添加背景颜色
                    filled: true,
                    fillColor: Colors.white12,
                    //输入光标颜色
                    focusedBorder: OutlineInputBorder(
                      //添加输入框四角边框
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(
                          color: Colors.transparent, width: 1), //设置选中状态的边框
                    ),
                  ),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("角色名称"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _name_Controller,
                  decoration: InputDecoration(
                      hintText: "角色名称"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("地图ID"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _map_id_Controller,
                  decoration: InputDecoration(
                      hintText: "地图ID"),
                ),
              )
            ]),
            // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //   Text("地图ID"),
            //   Container(
            //     // width: 150,
            //     // height: 30,
            //     child: TextField(
            //       controller: _map_id_Controller,
            //       decoration: InputDecoration(
            //         // contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
            //         hintText: "地图ID",
            //         //添加背景颜色
            //         // filled: true,
            //         // fillColor: Colors.white12,
            //         //输入光标颜色
            //         // focusedBorder: OutlineInputBorder(
            //         //   //添加输入框四角边框
            //         //   borderRadius: BorderRadius.circular(1),
            //         //   borderSide: BorderSide(
            //         //       color: Colors.transparent, width: 1), //设置选中状态的边框
            //         // ),
            //       ),
            //     ),
            //   )
            // ]),
          ],
        ),
      ), //确定按钮
      confirm: TextButton(
          onPressed: () {
            //搜索框值
            logic.s_id = _id_Controller.text;
            logic.s_name = _name_Controller.text;
            logic.s_map = _map_id_Controller.text;
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


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: GetBuilder<PlayUserLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: const Row(
                    children: [
                      Text("玩家管理"),
                    ],
                  ),
                  actions: [
                    IconButton(onPressed: (){
                      Get.toNamed("/play/user/give",
                          arguments: {
                            "name": "",
                            "id": "0"
                          });
                    }, icon: Icon(Symbols.add_2_rounded))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _showSearchDialog();
                  },
                  shape: const CircleBorder(
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
                body: GetBuilder<PlayUserLogic>(
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
                                  extentRatio:0.7,
                                  dragDismissible:false,
                                  motion: const ScrollMotion(),

                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      spacing: 2,
                                      onPressed: (value) => {

                                        Get.toNamed("/play/user/give",
                                            arguments: {
                                              "data": logic.list[index],
                                              "name": logic.list[index].name,
                                              "id": logic.list[index].id
                                                  .toString()
                                            })
                                      },
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: '发放资源',
                                    ),

                                  ],
                                ),
                                child: Card(
                                  elevation: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration:
                                    BoxDecoration(color: Colors.white70),
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        title: Text(
                                          "${logic.list[index].name}(${logic.list[index].id})",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            Text(
                                                "地图:${logic.list[index].map.toString()}",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            Text(
                                                "职业:${logic.list[index].jobName.toString()}(${logic.list[index].job.toString()})",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            Text(
                                                "等级:${logic.list[index].level.toString()}",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            Text(
                                                "GM等级:${logic.list[index].gm.toString()}",
                                                style: TextStyle(
                                                    color: Colors.black))
                                          ],
                                        ),
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                            size: 30.0),
                                        onTap: () {
                                          Get.toNamed("/play/user/give",
                                              arguments: {
                                                "data": logic.list[index],
                                                "name": logic.list[index].name,
                                                "id": logic.list[index].id
                                                    .toString()
                                              });
                                        }),
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
