import 'package:flutter/material.dart';

class GameConfigEntity  {

  late int id;

  /**
   * 参数类型
   */
  late String configType;

  /**
   * 参数子类型
   */
  late String configSubType;

  /**
   * 参数值java类型
   */
  late String configClazz;

  /**
   * 参数名
   */
  late String configCode;

  /**
   * 参数值
   */
  late String configValue;

  /**
   * 参数描述
   */
  late String configDesc;

  /**
   * 更新时间
   */
  late String updateTime;

  GameConfigEntity(
      this.id,
      this.configType,
      this.configSubType,
      this.configClazz,
      this.configCode,
      this.configValue,
      this.configDesc,
      this.updateTime);
  GameConfigEntity.fromJson(Map<String, dynamic> json)
      : id = json['id']?? 0,
        configType = json['configType']?? '',
        configSubType = json['configSubType']?? '',
        configClazz = json['configClazz']?? '',
        configCode = json['configCode']?? '',
        configValue = json['configValue']?? '',
        configDesc = json['configDesc']?? '',
        updateTime = json['updateTime']?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'configType': configType,
    'configSubType': configSubType,
    'configClazz': configClazz,
    'configCode': configCode,
    'configValue': configValue,
    'configDesc': configDesc,
    'updateTime': updateTime,
  };
  static List<GameConfigEntity> fromList(List<dynamic> list) {
    return list.map((e) => GameConfigEntity.fromJson(e)).toList();
  }
}
