import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GameInfoComponent extends StatelessWidget {
  GameInfoComponent({Key? key}) : super(key: key);

  final GameInfoLogic logic = Get.put(GameInfoLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      GridView.builder( gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.95,
      ), itemBuilder: (context, index){
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            // border: new Border.all(color: Colors.black87, width: 0.5), // border
            borderRadius: BorderRadius.circular((20)), // 圆角
          ),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/"+logic.gridViewList[index].image,
                  // width: 100,
                  // height: 100,
                  fit: BoxFit.fitHeight,
                  // color: Colors.green,
                  width: 60,
                ),
                Text(logic.gridViewList[index].title),
              ]
            ),
            onTap: ()=>Get.toNamed(logic.gridViewList[index].route),
          )
        );

      },itemCount: logic.gridViewList.length,)

      ,);
  }
}
