import 'package:flutter/material.dart';

class NPCEntity{
  late int shopId;
  late int npcId;
  late String npcName;

  NPCEntity(this.shopId, this.npcId, this.npcName);

  NPCEntity.build(this.shopId, this.npcId, this.npcName);

  NPCEntity.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    npcId = json['npcId'];
    npcName = json['npcName'];
  }
  Map<String, dynamic> toJson() => {
    'shopId': shopId,
    'npcId': npcId,
    'npcName': npcName
  };
  String toString() => 'shopId: $shopId, npcId: $npcId, npcName: $npcName';
  //list
  static List<NPCEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NPCEntity.fromJson(json)).toList();
  }
}
