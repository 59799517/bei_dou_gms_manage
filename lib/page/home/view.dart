import 'package:bei_dou_gms_manage/api/page/LoginApi.dart';
import 'package:bei_dou_gms_manage/storage/DBStorage.dart';
import 'package:bei_dou_gms_manage/theme/SqColors.dart';
import 'package:bei_dou_gms_manage/theme/ThemeIogic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: logic.drawerKey,
      drawer: GFDrawer(
          color: Colors.transparent,
          colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
          child: Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: GetBuilder<HomeLogic>(
                      id: logic.V_drawer_Name,
                      builder: (logic) {
                        return GFDrawerHeader(
                          closeButton: const Icon(
                            Icons.close,
                            size: 0,
                          ),
                          decoration: BoxDecoration(
                            color: SqColors.bottom_bar_colors[logic
                                .currentIndex],
                          ),
                          currentAccountPicture: const GFAvatar(
                            radius: 80.0,
                            backgroundImage:
                            AssetImage("assets/images/login_button4.png"),
                            backgroundColor: Colors.transparent,
                            size: GFSize.MEDIUM,
                            shape: GFAvatarShape.standard,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('BeiDou管理工具'),
                              Text(
                                  '出现问题请提iiues：https://github.com/xxxx/xxxx.git'),
                            ],
                          ),
                        );
                      }),
                ),
                Expanded(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: ListTile(
                          title: Text('账户列表'),
                          leading: Icon(Icons.account_circle),
                          onTap: () {
                            Get.toNamed('/play/account');
                          },
                        ),
                      ), Container(
                        child: Column(
                          children: [
                            GetBuilder<ThemeIogic>(builder: (logic) {
                              ThemeMode currentTheme = logic.currentTheme;
                              var icontype = Icon(Symbols.wb_sunny_rounded);
                              List<String> list = ["亮", "暗","自动"];
                              int index = 0;
                              if (currentTheme == ThemeMode.dark) {
                                index=1;
                                icontype = Icon(Symbols.dark_mode_rounded);
                              }else if(currentTheme==ThemeMode.light){
                                index=0;
                                icontype = Icon(Symbols.wb_sunny_rounded);
                              }else{
                                index=2;
                                icontype = Icon(Symbols.settings_brightness_rounded);
                              }
                              return ListTile(
                                title: Text(
                                  '切换主题', textAlign: TextAlign.right,),
                                trailing: icontype,
                                onTap: () async {
                                  Get.defaultDialog(
                                    title: "主题设置",
                                    content: Container(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Container(
                                                height: 35,
                                                child: ToggleSwitch(
                                                  minWidth: 90.0,
                                                  minHeight: 90.0,
                                                  fontSize: 16.0,
                                                  initialLabelIndex: index,
                                                  activeBgColor: [Colors.green],
                                                  activeFgColor: Colors.white,
                                                  inactiveFgColor: Colors
                                                      .grey[900],
                                                  totalSwitches: list.length,
                                                  icons: const [
                                                    Symbols.wb_sunny_rounded,
                                                    Symbols.dark_mode_rounded,
                                                    Symbols.settings_brightness_rounded
                                                  ],
                                                  labels: [...list],
                                                  onToggle: (index) {
                                                    index = index!;
                                                    if (index == 0) {
                                                      logic.onThemeChanged("light");
                                                    } else if (index == 1) {
                                                      logic.onThemeChanged("dark");
                                                    } else {
                                                     logic.onThemeChanged("auto");
                                                    }
                                                  },
                                                ),
                                              ),

                                            ]
                                        )),
                                    barrierDismissible: true,
                                    // backgroundColor: Colors.white,
                                    radius: 0,
                                  );
                                },
                              );
                            }),
                            ListTile(
                              title: Text(
                                '退出登录', textAlign: TextAlign.right,),
                              trailing: Icon(Icons.logout),
                              onTap: () async {
                                BDStorage().clearAll();
                                await LoginApi.instance?.logout();
                                Get.offAllNamed('/login');
                              },
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                )
              ],
            ),
          )


        // ListView(
        //   padding: EdgeInsets.zero,
        //   children: <Widget>[
        //
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Container(
        //           child: ListTile(
        //             title: Text('账户列表'),
        //             leading: Icon(Icons.account_circle),
        //             onTap: () {
        //               Get.toNamed('/play/account');
        //             },
        //           ),
        //         ),                Container(
        //           child: ListTile(
        //             title: Text('退出登录'),
        //             leading: Icon(Icons.account_circle),
        //             onTap: () {
        //               Get.toNamed('/play/account');
        //             },
        //           ),
        //         )
        //
        //       ],
        //     )
        //     // const ListTile(
        //     //   title: Text('Item 2'),
        //     // ),
        //   ],
        // ),
      ),
      appBar: AppBar(
        title: GetBuilder<HomeLogic>(
            id: logic.V_appbar_Name,
            builder: (logic) {
              return Text(
                logic.bottom_bar_View[logic.currentIndex],
                style: TextStyle(fontSize: 20),
              );
            }),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            logic.openDrawer();
          },
        ),
      ),
      body: GetBuilder<HomeLogic>(
          id: logic.V_body_Name,
          builder: (logic) {
            return logic.body_View[logic.currentIndex];
          }),
      bottomNavigationBar: GetBuilder<HomeLogic>(
        id: logic.V_bar_Name,
        builder: (logic) {
          return SalomonBottomBar(
            currentIndex: logic.currentIndex,
            onTap: (i) {
              logic.changeIndex(i);
            },
            items: [
              SalomonBottomBarItem(
                icon: Icon(Symbols.games_rounded),
                title: Text(logic.bottom_bar_View[0]),
                selectedColor: SqColors.bottom_bar_colors[0],
              ),

              SalomonBottomBarItem(
                icon: Icon(Symbols.search),
                title: Text(logic.bottom_bar_View[1]),
                selectedColor: SqColors.bottom_bar_colors[1],
              ),

              SalomonBottomBarItem(
                icon: Icon(Symbols.manage_accounts_rounded),
                title: Text(logic.bottom_bar_View[2]),
                selectedColor: SqColors.bottom_bar_colors[2],
              ),

              SalomonBottomBarItem(
                icon: Icon(Symbols.dns),
                title: Text(logic.bottom_bar_View[3]),
                selectedColor: SqColors.bottom_bar_colors[3],
              ),
            ],
          );
        },
      ),
    );
  }
}
