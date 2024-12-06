import 'package:flutter/material.dart';

class PlayUserOnlineEntity  {
  late int world;
  late int id;
  late String name;
  late int map;
  late int job;
  late String jobName;
  late int level;
  late int gm;

  PlayUserOnlineEntity(this.world, this.id, this.name, this.map, this.job,
      this.jobName, this.level, this.gm);

  //tojson
  Map<String, dynamic> toJson() => {
    'world': world,
    'id': id,
    'name': name,
    'map': map,
    'job': job,
    'jobName': jobName,
    'level': level,
    'gm': gm,
  };
  PlayUserOnlineEntity.fromJson(Map<String, dynamic> json) {
    world = json['world'];
    id = json['id'];
    name = json['name'];
    map = json['map'];
    job = json['job'];
    jobName = json['jobName'];
    level = json['level'];
    gm = json['gm'];
  }
//list
  static List<PlayUserOnlineEntity> fromJsonList(List<dynamic> jsonList) {
    List<PlayUserOnlineEntity> list = [];
    for (var json in jsonList) {
      list.add(PlayUserOnlineEntity.fromJson(json));
    }
    return list;
  }
}
