import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/entity/GachaponEntity.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/gachapon_edit/logic.dart';
import 'package:bei_dou_gms_manage/page/home/game_info/gachapon_shop/logic.dart';
import 'package:bei_dou_gms_manage/util/MSImageUtils.dart';
import 'package:bei_dou_gms_manage/util/WidgetUtils.dart';
import 'package:bei_dou_gms_manage/widget/SQListTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class GachaponEditComponent extends StatefulWidget {
  @override
  State<GachaponEditComponent> createState() => _GachaponEditComponentState();
}

class _GachaponEditComponentState extends State<GachaponEditComponent> {

  final GachaponEditLogic logic = Get.put(GachaponEditLogic());
  final GachaponShopLogic gachaponshoplogic = Get.put(GachaponShopLogic());

  String appBarTitle = "百宝箱编辑";
  Map<String, dynamic> data = Get.arguments;
  @override
  void initState() {
    super.initState();
    appBarTitle = data["name"];
  }


  @override
  void dispose() {
    super.dispose();
    gachaponshoplogic.reqSearchList(clear: true);
  }

  _showDialog(String title, String keyName,{defaultValue="",BuildContext? context,String subTitle="",WidgetType type=WidgetType.input,InputType inputType=InputType.number}) {
    WidgetUtils.showDialog(title, keyName, (value){
      if (type == WidgetType.input) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.date) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.toggle) {
        var json = data["data"]!.toJson();
        json[keyName] = value;
        var pushdata = GachaponEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.sex) {
        var json = data["data"]!.toJson();
        if( value=="男"){
          value="0";
        }else if( value=="女"){
          value="1";
        }else if( value=="通用"){
          value="2";
        }
        json[keyName] = value;
        var pushdata = GachaponEntity.fromJson(json);
        data["data"] = pushdata;
              logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }else if (type == WidgetType.slider) {
        var json = data["data"]!.toJson();
        json[keyName] = (double.parse(value)*10000);
        var pushdata = GachaponEntity.fromJson(json);
        data["data"] = pushdata;
        logic.reqUpdateData(json);
        logic.update([logic.V_list_body_view]);
      }
    }, context: context,defaultValue:defaultValue, subTitle:subTitle,type: type,inputType: inputType);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: GetBuilder<GachaponEditLogic>( id: logic.V_list_body_view, builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Card(
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child:
                             Image(
                              image: NetworkImage(MSImageUtils.getIconUrl(
                                category: "npc",
                                itemId:
                                data["data"]!.gachaponId,
                              )),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                    Symbols.error_circle_rounded);
                              }, fit: BoxFit.cover,),
                          ),
                          Text(data["data"]!.gachaponName),
                          Text("${data["data"]!.name}"),
                        ],
                      ),
                    )
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                            children: [
                              SQListTile(
                                titleText: "奖池ID",
                                subTitleText: data["data"]!.id.toString(),
                              ),
                              SQListTile(
                                  titleText: "是否公共池",
                                  subTitleText: data["data"]!.isPublic?"是":"否",
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("是否公共池", "isPublic",defaultValue: data["data"]!.isPublic.toString(),type: WidgetType.toggle);
                                  }
                              ),
                              SQListTile(
                                  titleText: "奖池名称",
                                  subTitleText: data["data"]!.name
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("奖池名称", "name",defaultValue: data["data"]!.name,type: WidgetType.input,inputType: InputType.text);
                                  }
                              ),
                              data["data"]!.isPublic?Container():
                              SQListTile(
                                  titleText: "百宝箱ID",
                                  subTitleText: data["data"]!.gachaponId
                                      .toString(),
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    _showDialog("百宝箱ID", "gachaponId",defaultValue: data["data"]!.gachaponId.toString(),type: WidgetType.input);
                                  }
                              ),
                              SQListTile(
                                titleText: "权重（概率）",
                                subTitleText:  bool.parse(data["data"]!.isPublic.toString())? "${data["data"]!.prob.toString()}": "${data["data"]!.weight.toString()}",
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: (){
                                  if(bool.parse(data["data"]!.isPublic.toString())){
                                    //只计算自己的权重
                                    data["data"]!.gachaponId = -1;
                                    _showDialog("权重(概率)", "prob",defaultValue: (double.parse(data["data"]!.prob.toString())/10000).toString(),type: WidgetType.slider);
                                  }else{
                                    //查询相邻的权重
                                    gachaponshoplogic.searchValue=data["data"]!.gachaponId.toString();
                                    gachaponshoplogic.reqSearchList(clear: true).then((value){
                                      if(value["code"] == 20000){
                                        List<GachaponEntity> list = GachaponEntity.fromJsonList(value["data"]['records']);
                                        Map<String, double> map={};
                                        list.forEach((element) {
                                          print("当前判断${element.id.toString()!=data["data"]!.id.toString()} /  element.id: ${element.id.toString()} / data!.id: ${data["data"]!.id.toString()}");
                                          if(element.id.toString()!=data["data"]!.id.toString()){
                                            map[element.name]=double.parse(element.weight.toString());
                                          }
                                        });
                                        WidgetUtils.showProbDialog("权重（概率）", "weight",(value){
                                          var weight =  value['weight'];
                                          var prob =    value['prob'];
                                          var json = data["data"]!.toJson();
                                          json['weight'] = weight;
                                          json['realProb'] = prob;
                                          var pushdata = GachaponEntity.fromJson(json);
                                          data["data"] = pushdata;
                                          logic.reqUpdateData(json);
                                          logic.update([logic.V_list_body_view]);
                                        }, map,data["data"]!.weight);

                                      }else{
                                        Get.showSnackbar(value["message"]);
                                      }
                                    });
                                  }

                                },
                              ),
                              SQListTile(
                                titleText: "生效时间",
                                subTitleText: data["data"]!.startTime.toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () async{
                                  _showDialog("生效时间", "startTime",type: WidgetType.date,defaultValue: data["data"]!.startTime.toString());

                                },
                              ),
                              SQListTile(
                                titleText: "结束时间",
                                subTitleText: data["data"]!.endTime.toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () async{
                                  _showDialog("结束时间", "endTime",type: WidgetType.date);
                                },
                              ),
                              SQListTile(
                                titleText: "全服通知",
                                subTitleText: data["data"]!.notification?"是":"否",
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("全服通知", "notification",defaultValue: data["data"]!.notification.toString(),type: WidgetType.toggle);
                                },
                              ),
                              SQListTile(
                                titleText: "描述",
                                subTitleText: data["data"]!.comment.toString(),
                                icon: Icon(Icons.keyboard_arrow_right),
                                onTap: () {
                                  _showDialog("描述", "comment",type: WidgetType.input,inputType: InputType.text);
                                },
                              ),
                            ]
                        ),
                      )

                    ],

                  )
              ),
            ),


          ],
        );
      }),


    );
  }
}
