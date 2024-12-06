import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
///用户信息
///

enum StoreKeys { token, username, password ,baseUrl,nickName,userId,themeConfig}

class BDStorage  {

  static BDStorage _storage = BDStorage._internal();
  final GetStorage _box = GetStorage();


  GetStorage get box => _box;

  BDStorage._internal();

  factory BDStorage() => _storage;

  ///token
  setToken (String token)=> _box.write(StoreKeys.token.toString(), token);
  String getToken ()=> _box.hasData(StoreKeys.token.toString())?_box.read(StoreKeys.token.toString()):"";

  ///用户名
  setUsername (String username)=> _box.write(StoreKeys.username.toString(), username);
  String getUsername ()=> _box.hasData(StoreKeys.username.toString())?_box.read(StoreKeys.username.toString()):"";

  ///密码
  setPassword (String password)=> _box.write(StoreKeys.password.toString(), password);
  String getPassword ()=> _box.hasData(StoreKeys.password.toString())?_box.read(StoreKeys.password.toString()):"";

  ///域名
  setBaseUrl (String baseUrl)=> _box.write(StoreKeys.baseUrl.toString(), baseUrl);
  String getBaseUrl ()=> _box.hasData(StoreKeys.baseUrl.toString())?_box.read(StoreKeys.baseUrl.toString()):"";

  ///昵称
  setNickName (String nickName)=> _box.write(StoreKeys.nickName.toString(), nickName);
  String getNickName ()=> _box.hasData(StoreKeys.nickName.toString())?_box.read(StoreKeys.nickName.toString()):"";

  ///用户id
  setUserId (String userId)=> _box.write(StoreKeys.userId.toString(), userId);
  String getUserId ()=> _box.hasData(StoreKeys.userId.toString())? _box.read(StoreKeys.userId.toString()):"";

  setThemeConfig (String themeConfig)=> _box.write(StoreKeys.themeConfig.toString(), themeConfig);
  String getThemeConfig ()=> _box.hasData(StoreKeys.themeConfig.toString())?_box.read(StoreKeys.themeConfig.toString()):"";

  //获取全部的key
  List<String> getAllKeys(){
    return _box.getKeys().toList();
  }
  //清理所有数据
  clearAll(){
    _box.erase();
  }
}
