import 'package:flutter/material.dart';

class GachaponPrizeEntity {


  /**
   * 自增ID
   */
  late int id;

  /**
   * 绑定奖池ID
   */
  late int poolId;

  /**
   * 道具ID
   */
  late int itemId;

  /**
   * 道具名称
   */
  late String itemName;

  /**
   * 单次抽取数量
   */
  late int quantity;

  /**
   * 创建日期
   */
  late String createTime;

  /**
   * 备注
   */
  late String comment;

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

  GachaponPrizeEntity(this.id, this.poolId, this.itemId, this.itemName,
      this.quantity, this.createTime, this.comment);
  GachaponPrizeEntity.fromJson(Map<String, dynamic> json)
      : id = parseInt(json['id']),
        poolId = parseInt(json['poolId']),
        itemId = parseInt(json['itemId']),
        itemName = json['itemName'] ?? '',
        quantity = parseInt(json['quantity']),
        createTime = json['createTime'] ?? '',
        comment = json['comment'] ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'poolId': poolId,
    'itemId': itemId,
    'itemName': itemName,
    'quantity': quantity,
    'createTime': createTime,
    'comment': comment,
  };
  static List<GachaponPrizeEntity> fromJsonList(List<dynamic> jsonList) => jsonList.map((json) => GachaponPrizeEntity.fromJson(json)).toList();
}
