import 'package:flutter/material.dart';

class GameGlobalEntity  {

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

  GameGlobalEntity(
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
  //json
  static GameGlobalEntity fromJson(Map<String, dynamic> json) => GameGlobalEntity(
    parseInt(json['id']),
    parseInt(json['dropperId']),
    json['dropperName']?? '',
    parseInt(json['continent']),
    parseInt(json['itemId']),
    json['itemName']?? '',
    parseInt(json['minimumQuantity']),
    parseInt(json['maximumQuantity']),
    parseInt(json['questId']),
    json['questName'],
    parseInt(json['chance']),
    json['comments'],
  );
  static List<GameGlobalEntity> fromJsonList(List<dynamic> jsonList) => jsonList.map((json) => fromJson(json)).toList();

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
}
