import 'package:bei_dou_gms_manage/theme/SqColors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'logic.dart';

class BarHomeComponent extends StatelessWidget {
  BarHomeComponent({Key? key}) : super(key: key);

  final BarHomeLogic logic = Get.put(BarHomeLogic());




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GetBuilder<BarHomeLogic>(id: logic.V_Online_view, builder: (logic) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 8,
                                            child: InkWell(
                                              onTap: () {
                                                //弹出消息提醒正在刷新
                                                BotToast.showText(text:"正在刷新服务状态请稍后。。。");
                                                logic.getOnlineStatus();
                                              },
                                              child: Image.asset(
                                                "assets/images/服务器.png",
                                                // width: 100,
                                                // height: 100,
                                                fit: BoxFit.fitHeight,
                                                color: logic.online?Colors.greenAccent:Colors.redAccent,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 10,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Text("当前运行状态:",
                                                    style:
                                                    TextStyle(fontSize: 18)),
                                                 Text(logic.online?"运行中。。。":"已停止。。。",
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontSize: 15)),
                                                Column(
                                                  children: [
                                                    Row(children: [
                                                      Container(
                                                        margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                        child: GFButton(
                                                          text: "启动服务",
                                                          onPressed: logic.online?null:() {
                                                            BotToast.showText(text:"正在启动服务请稍后。。。");
                                                            logic.startService();
                                                          },
                                                          shape: GFButtonShape
                                                              .square,
                                                          color:
                                                          Colors.greenAccent,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                        child: GFButton(
                                                          text: "停止服务",
                                                          onPressed:!logic.online? null:() {
                                                            BotToast.showText(text:"正在停止服务请稍后。。。");
                                                            logic.stopService();

                                                          },
                                                          shape: GFButtonShape
                                                              .square,
                                                          color: Colors
                                                              .redAccent,
                                                        ),
                                                      ),
                                                    ]),
                                                    Row(children: [
                                                      Container(
                                                        margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                        child: GFButton(
                                                          text: "重启服务",
                                                          onPressed: () {
                                                            BotToast.showText(text:"正在重启服务请稍后。。。");
                                                            logic.restartService();
                                                          },
                                                          shape: GFButtonShape
                                                              .square,
                                                          color:
                                                          Colors.orangeAccent,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                        child: GFButton(
                                                          text: "停服",
                                                          onPressed: () {
                                                            BotToast.showText(text:"正在关闭服务请稍后。。。");
                                                            logic.closeService();
                                                          },
                                                          shape: GFButtonShape
                                                              .square,
                                                          color: Colors
                                                              .redAccent,
                                                        ),
                                                      )
                                                    ])
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: const Text("暂无内容"),
                ),
              )
            ],
          )),
    );
  }
}
