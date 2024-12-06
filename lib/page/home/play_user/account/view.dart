import 'package:bei_dou_gms_manage/page/home/play_user/account/logic.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountComponent extends StatefulWidget {
  @override
  State<AccountComponent> createState() => _AccountComponentState();
}

class _AccountComponentState extends State<AccountComponent> {
  final AccountLogic logic = Get.put(AccountLogic());
  ScrollController _scrollController = ScrollController();

  final TextEditingController _id_Controller = TextEditingController();
  final TextEditingController _name_chController = TextEditingController();
  final TextEditingController _lastLoginStart_enController =
      TextEditingController();
  final TextEditingController _lastLoginEnd_enController =
      TextEditingController();
  final TextEditingController _createdAtStart_enController =
      TextEditingController();
  final TextEditingController _createdAtEnd_enController =
      TextEditingController();

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
                  controller: _id_Controller,
                  decoration: InputDecoration(
                    hintText: "ID",
                  ),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("账户"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _name_chController,
                  decoration: InputDecoration(
                      hintText: "账户"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("登录时间开始"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _lastLoginStart_enController,
                  decoration: InputDecoration(
                    hintText: "登录时间开始",
                  ),
                  keyboardType: TextInputType.datetime,
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("登录时间结束"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _lastLoginEnd_enController,
                  decoration: InputDecoration(
                      hintText: "登录时间结束"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("创建时间开始"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _createdAtStart_enController,
                  decoration: InputDecoration(
                      hintText: "创建时间开始"),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("创建时间结束"),
              Container(
                width: 150,
                height: 50,
                child: TextField(
                  controller: _createdAtEnd_enController,
                  decoration: InputDecoration(
                      hintText: "创建时间结束"),
                ),
              )
            ]),
          ],
        ),
      ), //确定按钮
      confirm: TextButton(
          onPressed: () {
            //搜索框值
            logic.s_id = _id_Controller.text;
            logic.s_name = _name_chController.text;
            logic.s_lastLoginStart = _lastLoginStart_enController.text;
            logic.s_lastLoginEnd = _lastLoginEnd_enController.text;
            logic.s_createdAtStart = _createdAtStart_enController.text;
            logic.s_createdAtEnd = _createdAtEnd_enController.text;
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
      child: GetBuilder<AccountLogic>(
          id: "tabrView",
          builder: (logic) {
            return Scaffold(
                appBar: AppBar(
                  title: const Row(
                    children: [
                      Text("账户列表"),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Get.toNamed(
                            "/play/account/add",
                          );
                        },
                        icon: Icon(Symbols.add_2_rounded))
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
                body: GetBuilder<AccountLogic>(
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
                                  extentRatio: 0.7,
                                  dragDismissible: false,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      spacing: 2,
                                      onPressed: (value) => {
                                        logic
                                            .delete(
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
                                      flex: 2,
                                      spacing: 2,
                                      onPressed: (value) => {
                                        Get.toNamed("/play/account/edit",
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
                                      label: '编辑',
                                    ),
                                    SlidableAction(
                                      flex: 2,
                                      spacing: 2,
                                      onPressed: (value) => {
                                        logic
                                            .unLock(
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
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                      icon: Symbols.check_circle,
                                      label: '解卡',
                                    ),
                                    logic.list[index].banned
                                        ? SlidableAction(
                                            flex: 2,
                                            spacing: 2,
                                            onPressed: (value) => {
                                              logic
                                                  .unban(logic.list[index].id
                                                      .toString())
                                                  .then((value) => {
                                                        logic
                                                            .getData(
                                                                clear: true)
                                                            .then((val) => {
                                                                  logic.update([
                                                                    logic
                                                                        .V_show_doby_view
                                                                  ])
                                                                })
                                                      })
                                            },
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            icon: Symbols.account_circle,
                                            label: '解封',
                                          )
                                        : SlidableAction(
                                            flex: 2,
                                            spacing: 2,
                                            onPressed: (value) => {
                                              WidgetUtils.showDialog(
                                                "封禁",
                                                "",
                                                (value) {
                                                  logic
                                                      .ban(
                                                          logic.list[index].id
                                                              .toString(),
                                                          value)
                                                      .then((value) => {
                                                            logic
                                                                .getData(
                                                                    clear: true)
                                                                .then((val) => {
                                                                      logic
                                                                          .update([
                                                                        logic
                                                                            .V_show_doby_view
                                                                      ])
                                                                    })
                                                          });
                                                },
                                                subTitle:
                                                    "确定封禁账号${logic.list[index].name}?",
                                                context: context,
                                                defaultValue: "无",
                                              )
                                            },
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: Symbols.no_accounts_rounded,
                                            label: '封禁',
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
                                          "${logic.list[index].name}(${logic.list[index].id})",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Container(
                                          child: Row(
                                            children: <Widget>[
                                              // Icon(Icons.lock_open_outlined, color: Colors.blue),
                                              Container(
                                                // width: double.infinity,
                                                child: Text(
                                                  "登录时间:${logic.list[index].lastlogin.toString()}",
                                                  overflow: TextOverflow.ellipsis, //长度溢出后显示省略号
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 30.0),
                                        onTap: () {
                                          Get.toNamed("/play/account/edit",
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
