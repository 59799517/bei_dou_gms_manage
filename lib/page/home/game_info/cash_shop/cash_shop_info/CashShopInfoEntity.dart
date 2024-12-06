import 'package:flutter/material.dart';

class CashShopInfoEntity  {

  // SN码
  final int sn;
  // 物品Id（图片码）
  final int itemId;
  // 物品名称
  final String itemName;
  // 售价
  final int price;
  // 有效期（天）
  final int period;
  // 优先级
  final int priority;
  // 数量
  final int count;
  // 上架 非空 上架中 待售
  final int onSale;
  // 直接叫 bonus
  final int bonus;
  // 抵用券
  final int maplePoint;
  // 金币
  final int meso;
  // 会员专属
  final int forPremiumUser;
  // 性别 0  男 1 女 2 通用
  final int gender;
  // 标签 0 NEW 1 SALE 2 HOT 3 EVENT
  final int clz;
  // 直接叫 limit
  final int limit;
  // 直接叫 pbCash
  final int pbCash;
  // 直接叫 pbPoint
  final int pbPoint;
  // 直接叫 pbGift
  final int pbGift;
  // 礼包合集
  final int packageSn;

  const CashShopInfoEntity({
    required this.sn,
    required this.itemId,
    required this.itemName,
    required this.price,
    required this.period,
    required this.priority,
    required this.count,
    required this.onSale,
    required this.bonus,
    required this.maplePoint,
    required this.meso,
    required this.forPremiumUser,
    required this.gender,
    required this.clz,
    required this.limit,
    required this.pbCash,
    required this.pbPoint,
    required this.pbGift,
    required this.packageSn,
  });

  factory CashShopInfoEntity.fromJson(Map<String, dynamic> json) {
    return CashShopInfoEntity(
      sn: parseInt(json['sn']),
      itemId: parseInt(json['itemId']),
      itemName: json['itemName']?.toString() ?? "",
      price: parseInt(json['price']),
      period: parseInt(json['period']),
      priority: parseInt(json['priority']),
      count: parseInt(json['count']),
      onSale: parseInt(json['onSale']),
      bonus: parseInt(json['bonus']),
      maplePoint: parseInt(json['maplePoint']),
      meso: parseInt(json['meso']),
      forPremiumUser: parseInt(json['forPremiumUser']),
      gender: parseInt(json['gender'], defaultValue: 2),
      clz: parseInt(json['clz']),
      limit: parseInt(json['limit']),
      pbCash: parseInt(json['pbCash']),
      pbPoint: parseInt(json['pbPoint']),
      pbGift: parseInt(json['pbGift']),
      packageSn: parseInt(json['packageSn']),
    );
  }

  Map<String, dynamic> toJson() => {
    'sn': sn,
    'itemId': itemId,
    'itemName': itemName,
    'price': price,
    'period': period,
    'priority': priority,
    'count': count,
    'onSale': onSale,
    'bonus': bonus,
    'maplePoint': maplePoint,
    'meso': meso,
    'forPremiumUser': forPremiumUser,
    'gender': gender,
    'clz': clz,
    'limit': limit,
    'pbCash': pbCash,
    'pbPoint': pbPoint,
    'pbGift': pbGift,
    'packageSn': packageSn,
  };

  static List<CashShopInfoEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CashShopInfoEntity.fromJson(json)).toList();
  }

  CashShopInfoEntity copyWith({
    int? sn,
    int? itemId,
    String? itemName,
    int? price,
    int? period,
    int? priority,
    int? count,
    int? onSale,
    int? bonus,
    int? maplePoint,
    int? meso,
    int? forPremiumUser,
    int? gender,
    int? clz,
    int? limit,
    int? pbCash,
    int? pbPoint,
    int? pbGift,
    int? packageSn,
  }) {
    return CashShopInfoEntity(
      sn: sn ?? this.sn,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      price: price ?? this.price,
      period: period ?? this.period,
      priority: priority ?? this.priority,
      count: count ?? this.count,
      onSale: onSale ?? this.onSale,
      bonus: bonus ?? this.bonus,
      maplePoint: maplePoint ?? this.maplePoint,
      meso: meso ?? this.meso,
      forPremiumUser: forPremiumUser ?? this.forPremiumUser,
      gender: gender ?? this.gender,
      clz: clz ?? this.clz,
      limit: limit ?? this.limit,
      pbCash: pbCash ?? this.pbCash,
      pbPoint: pbPoint ?? this.pbPoint,
      pbGift: pbGift ?? this.pbGift,
      packageSn: packageSn ?? this.packageSn,
    );
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
