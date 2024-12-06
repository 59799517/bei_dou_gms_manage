import 'package:flutter/material.dart';

class AccountsEntity {

  late int id;

  late String name;

  late String pin;

  late String pic;

  late int loggedin;

  late String lastlogin;

  late String createdat;

  late String birthday;

  late bool banned;

  late String banreason;

  late String macs;

  late int nxCredit;

  late int maplePoint;

  late int nxPrepaid;

  late int characterslots;

  late int gender;

  late String tempban;

  late int greason;

  late bool tos;

  late String sitelogged;

  late int webadmin;

  late String nick;

  late int mute;

  late String email;

  late String ip;

  late int rewardpoints;

  late int votepoints;

  late String hwid;

  late int language;

  //扩充字段
  late String newPwd;
  late String newPwdCheck;


  AccountsEntity(
      this.id,
      this.name,
      this.pin,
      this.pic,
      this.loggedin,
      this.lastlogin,
      this.createdat,
      this.birthday,
      this.banned,
      this.banreason,
      this.macs,
      this.nxCredit,
      this.maplePoint,
      this.nxPrepaid,
      this.characterslots,
      this.gender,
      this.tempban,
      this.greason,
      this.tos,
      this.sitelogged,
      this.webadmin,
      this.nick,
      this.mute,
      this.email,
      this.ip,
      this.rewardpoints,
      this.votepoints,
      this.hwid,
      this.language,
      this.newPwd,
      this.newPwdCheck
      );
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
  static AccountsEntity fromJson(Map<String, dynamic> json) => AccountsEntity(
    parseInt(json['id']),
    json['name']?? '',
    json['pin']?? '',
    json['pic']?? '',
    parseInt(json['loggedin']),
    json['lastlogin']?? '',
    json['createdat']?? '',
    json['birthday']?? '',
    json['banned']?? false,
    json['banreason']?? '',
    json['macs']?? '',
    parseInt(json['nxCredit']),
    parseInt(json['maplePoint']),
    parseInt(json['nxPrepaid']),
    parseInt(json['characterslots']),
    parseInt(json['gender']),
    json['tempban']?? '',
    parseInt(json['greason']),
    json['tos']?? false,
    json['sitelogged']?? '',
    parseInt(json['webadmin']),
    json['nick']?? '',
    parseInt(json['mute']),
    json['email']??'',
    json['ip']?? '',
    parseInt(json['rewardpoints']),
    parseInt(json['votepoints']),
    json['hwid']?? '',
    parseInt(json['language']),
    '',
    '',
  );
  static List<AccountsEntity> fromJsonList(List<dynamic> jsonList) => jsonList.map((json) => fromJson(json)).toList();
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'pin': pin,
    'pic': pic,
    'loggedin': loggedin,
    'lastlogin': lastlogin,
    'createdat': createdat,
    'birthday': birthday,
    'banned': banned,
    'banreason': banreason,
    'macs': macs,
    'nxCredit': nxCredit,
    'maplePoint': maplePoint,
    'nxPrepaid': nxPrepaid,
    'characterslots': characterslots,
    'gender': gender,
    'tempban': tempban,
    'greason': greason,
    'tos': tos,
    'sitelogged': sitelogged,
    'webadmin': webadmin,
    'nick': nick,
    'mute': mute,
    'email': email,
    'ip': ip,
    'rewardpoints': rewardpoints,
    'votepoints': votepoints,
    'hwid': hwid,
    'language': language,
    'newPwd': newPwd,
    'newPwdCheck': newPwdCheck
  };
}
