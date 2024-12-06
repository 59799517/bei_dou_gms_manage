import 'dart:convert';

import 'package:flutter/material.dart';

class GachaponEntity  {
  late int realProb;
  /**
   * 自增ID
   */
  late int id;
  /**
   * 转蛋机奖池名称
   */
  late String name;
  /**
   * 绑定转蛋机ID
   */
  late int gachaponId;
  /**
   * 转蛋机名称
   */
  late String gachaponName;
  /**
   * 权重
   */
  late int weight;
  /**
   * 是否公共奖池 0为否 1为是
   */
  late bool isPublic;
  /**
   * 概率
   */
  late int prob;
  /**
   * 奖池的启用日期
   */
  late String startTime;
  /**
   * 奖池的结束日期
   */
  late String endTime;
  /**
   * 是否喇叭通知 0为否 1为是
   */
  late bool notification;
  /**
   * 备注
   */
  late String comment;

  GachaponEntity(
      this.realProb,
      this.id,
      this.name,
      this.gachaponId,
      this.gachaponName,
      this.weight,
      this.isPublic,
      this.prob,
      this.startTime,
      this.endTime,
      this.notification,
      this.comment);

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
  static GachaponEntity fromJson(Map<String, dynamic> json) => GachaponEntity(
    parseInt(json['realProb']),
    parseInt(json['id']),
    json['name']?? '',
    parseInt(json['gachaponId']),
    json['gachaponName']?? '',
    parseInt(json['weight']),
    json['isPublic']?? false,
    parseInt(json['prob']),
    json['startTime']?? '',
    json['endTime']?? '',
    json['notification']?? false,
    json['comment']?? '',
  );
  static List<GachaponEntity> fromJsonList(List<dynamic> jsonList) => jsonList.map((json) => fromJson(json)).toList();
  Map<String, dynamic> toJson() => {
    'realProb': realProb,
    'id': id,
    'name': name,
    'gachaponId': gachaponId,
    'gachaponName': gachaponName,
    'weight': weight,
    'isPublic': isPublic,
    'prob': prob,
    'startTime': startTime,
    'endTime': endTime,
    'notification': notification,
    'comment':comment,
  };


}
