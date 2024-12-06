import 'package:flutter/material.dart';

class MSImageUtils  {
  static String getIconUrl({required String category, required int itemId,String location ="GMS", String version ="83"}){
    return "https://maplestory.io/api/${location}/${version}/${category}/${itemId}/icon";
  }
  static String getIconUrlofIteamString({required String category, required String itemId,String location ="GMS", String version ="83"}){
    return "https://maplestory.io/api/${location}/${version}/${category}/${itemId}/icon";
  }
}
