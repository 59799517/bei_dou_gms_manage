import 'package:flutter/material.dart';

class BackpackEntity {
  /**
   * 自增id，对应inventoryitemid
   */
  late int id;
  /**
   * 角色id
   */
  late int characterId;
  /**
   * 物品id，对应itemid
   */
  late int itemId;
  /**
   * 物品类型，对应type
   * @see org.gms.client.inventory.ItemFactory
   */
  late int itemType;
  /**
   * 背包栏类型，对应inventorytype
   * @see org.gms.client.inventory.InventoryType
   */
  late int inventoryType;
  /**
   * 物品位置，对应position
   */
  late int position;
  /**
   * 物品数量，对应quantity
   */
  late int quantity;
  /**
   * 制作者，对应owner
   */
  late String owner;
  /**
   * 宠物id，对应petid
   */
  late int petId;
  /**
   * 物品标记，对应flag
   */
  late int flag;
  /**
   * 物品有效期，对应expiration
   */
  late int expiration;
  /**
   * 送礼人，对应giftFrom
   */
  late String giftFrom;
  /**
   * 是否在线
   */
  late bool online;
  /**
   * 是否装备，判断子表inventoryequipment是否有数据
   */
  late bool equipment;
  /**
   * 装备信息，equipment为true时有值
   */
  late InventoryEquipRtnDTO inventoryEquipment;

  /**
   *
   * 物品名称，根据itemID返回。
   */
  late String itemName;

  BackpackEntity(
      this.id,
      this.characterId,
      this.itemId,
      this.itemType,
      this.inventoryType,
      this.position,
      this.quantity,
      this.owner,
      this.petId,
      this.flag,
      this.expiration,
      this.giftFrom,
      this.online,
      this.equipment,
      this.inventoryEquipment,
      this.itemName);

  // list
  static List<BackpackEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BackpackEntity.fromJson(json)).toList();
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'characterId': characterId,
    'itemId': itemId,
    'itemType': itemType,
    'inventoryType': inventoryType,
    'position': position,
    'quantity': quantity,
    'owner': owner,
    'petId': petId,
    'flag': flag,
    'expiration': expiration,
    'giftFrom': giftFrom,
    'online': online,
    'equipment': equipment,
  };
  static BackpackEntity fromJson(Map<String, dynamic> json) {
    return BackpackEntity(
      json['id'],
      parseInt(json['characterId']),
      parseInt(json['itemId']),
      parseInt(json['itemType']),
      parseInt(json['inventoryType']),
      parseInt(json['position']),
      parseInt(json['quantity']),
      json['owner'],
      parseInt(json['petId']),
      parseInt(json['flag']),
      parseInt(json['expiration']),
      json['giftFrom']??"",
      json['online']??false,
      json['equipment']??false,
      json['inventoryEquipment']==null?InventoryEquipRtnDTO(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0):InventoryEquipRtnDTO.fromJson(json['inventoryEquipment']),
      json['itemName']??"",
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



class InventoryEquipRtnDTO {
  /**
   * 自增id，对应inventoryequipmentid
   */
  late int id;
  /**
   * 外键，关联inventoryitems表id
   */
  late int inventoryItemId;
  /**
   * 砸券次数，对应upgradeslots
   */
  late int upgradeSlots;
  /**
   * 装备等级，对应level
   */
  late int level;
  /**
   * 力量，对应str
   */
  late int attStr;
  /**
   * 敏捷，对应dex
   */
  late int attDex;
  /**
   * 智力，对应int
   */
  late int attInt;
  /**
   * 运气，对应luk
   */
  late int attLuk;
  /**
   * 血量，对应hp
   */
  late int hp;
  /**
   * 蓝量，对应mp
   */
  late int mp;
  /**
   * 物理攻击，对应watk
   */
  late int pAtk;
  /**
   * 魔法攻击，对应matk
   */
  late int mAtk;
  /**
   * 物理防御，对应wdef
   */
  late int pDef;
  /**
   * 魔法防御，对应mDef
   */
  late int mDef;
  /**
   * 命中，对应acc
   */
  late int acc;
  /**
   * 回避，对应avoid
   */
  late int avoid;
  /**
   * 攻速，对应hands
   */
  late int hands;
  /**
   * 移速，对应speed
   */
  late int speed;
  /**
   * 跳跃力，对应jump
   */
  late int jump;
  /**
   * 锁定，对应locked
   */
  late int locked;
  /**
   * 锤子次数，对应vicious
   */
  late int vicious;
  /**
   * 装备升级等级，对应itemlevel
   */
  late int itemLevel;
  /**
   * 装备升级经验，对应itemexp
   */
  late int itemExp;
  /**
   * 戒指id，对应ringid
   */
  late int ringId;

  InventoryEquipRtnDTO(
      this.id,
      this.inventoryItemId,
      this.upgradeSlots,
      this.level,
      this.attStr,
      this.attDex,
      this.attInt,
      this.attLuk,
      this.hp,
      this.mp,
      this.pAtk,
      this.mAtk,
      this.pDef,
      this.mDef,
      this.acc,
      this.avoid,
      this.hands,
      this.speed,
      this.jump,
      this.locked,
      this.vicious,
      this.itemLevel,
      this.itemExp,
      this.ringId);
  static InventoryEquipRtnDTO fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return InventoryEquipRtnDTO(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    }
    return InventoryEquipRtnDTO(

      json['id'],
      parseInt(json['inventoryItemId']),
      parseInt(json['upgradeSlots']),
      parseInt(json['level']),
      parseInt(json['attStr']),
      parseInt(json['attDex']),
      parseInt(json['attInt']),
      parseInt(json['attLuk']),
      parseInt(json['hp']),
      parseInt(json['mp']),
      parseInt(json['pAtk']),
      parseInt(json['mAtk']),
      parseInt(json['pDef']),
      parseInt(json['mDef']),
      parseInt(json['acc']),
      parseInt(json['avoid']),
      parseInt(json['hands']),
      parseInt(json['speed']),
      parseInt(json['jump']),
      parseInt(json['locked']),
      parseInt(json['vicious']),
      parseInt(json['itemLevel']),
      parseInt(json['itemExp']),
      parseInt(json['ringId'])
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'inventoryItemId': inventoryItemId,
    'upgradeSlots': upgradeSlots,
    'level': level,
    'attStr': attStr,
    'attDex': attDex,
    'attInt': attInt,
    'attLuk': attLuk,
    'hp': hp,
    'mp': mp,
    'pAtk': pAtk,
    'mAtk': mAtk,
    'pDef': pDef,
    'mDef': mDef,
    'acc': acc,
    'avoid': avoid,
    'hands': hands,
    'speed': speed,
    'jump': jump,
    'locked': locked,
    'vicious': vicious,
    'itemLevel': itemLevel,
    'itemExp': itemExp,
    'ringId': ringId
  };
  //list
  static List<InventoryEquipRtnDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => InventoryEquipRtnDTO.fromJson(json)).toList();
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
