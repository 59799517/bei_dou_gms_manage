import 'package:flutter/material.dart';

class NPCShopInfoEntity  {
  late int id;
  late int shopId;
  late int itemId;
  late int price;
  late int pitch;
  late int position;
  late String itemName;
  late String itemDesc;

  NPCShopInfoEntity(this.id, this.shopId, this.itemId, this.price, this.pitch,
      this.position, this.itemName, this.itemDesc);
  NPCShopInfoEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shopId'];
    itemId = parseInt(json['itemId']);
    price = parseInt(json['price']) ;
    pitch = parseInt(json['pitch']) ;
    position = parseInt(json['position']);
    itemName = json['itemName'];
    itemDesc = json['itemDesc']??"";
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'shopId': shopId,
        'itemId': itemId,
        'price': price,
        'pitch': pitch,
        'position': position,
        'itemName': itemName,
        'itemDesc': itemDesc
      };
  //list
  static List<NPCShopInfoEntity> fromJsonList(List list) {
    List<NPCShopInfoEntity> ret = [];
    for (var item in list) {
      ret.add(NPCShopInfoEntity.fromJson(item));
    }
    return ret;
  }

  /// 辅助方法：将动态类型转换为整数，如果转换失败则返回默认值
  static int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsedValue = int.tryParse(value);
      return parsedValue ?? defaultValue;
    }
    return defaultValue;
  }
}
