import 'package:flutter/material.dart';

class MonsterEntity {
  late int id;
  late int dropperId;
  late String dropperName;
  late int continent;
  late int itemId;
  late String itemName;
  late int minimumQuantity;
  late int maximumQuantity;
  late int questId;
  late String questName;
  late int chance;
  late String comments;

  MonsterEntity(
      this.id,
      this.dropperId,
      this.dropperName,
      this.continent,
      this.itemId,
      this.itemName,
      this.minimumQuantity,
      this.maximumQuantity,
      this.questId,
      this.questName,
      this.chance,
      this.comments);

  factory MonsterEntity.fromJson(Map<String, dynamic> json) {
    return MonsterEntity(
      parseInt(json['id']??0) ,
      parseInt(json['dropperId']??0),
      json['dropperName']??"",
      json['continent']??0,
      parseInt(json['itemId']??0) ,
      json['itemName']??"",
      parseInt(json['minimumQuantity']??0) ,
      parseInt(json['maximumQuantity']??0) ,
      parseInt(json['questId']??0),
      json['questName']??"",
      parseInt(json['chance']??0),
      json['comments']??"",
    );
  }
  static List<MonsterEntity> fromJsonList(List list) {
    return list.map((item) => MonsterEntity.fromJson(item)).toList();
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'dropperId': dropperId,
    'dropperName': dropperName,
    'continent': continent,
    'itemId': itemId,
    'itemName': itemName,
    'minimumQuantity': minimumQuantity,
    'maximumQuantity': maximumQuantity,
    'questId': questId,
    'questName': questName,
    'chance': chance,
    'comments':comments,
  };

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
