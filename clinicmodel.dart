// ignore: unused_import
import 'package:flutter/cupertino.dart';

class ClinicModel {
  late final String id;
  late final String name;
  late final String address;
  late final String tell;
  late final String img;
  late final String time;
  late final String type;
  late final String detail;
  late final String vehicle;
  late final String latitude;
  late final String longitude;

  ClinicModel({
    required this.id,
    required this.name,
    required this.address,
    required this.tell,
    required this.img,
    required this.time,
    required this.type,
    required this.detail,
    required this.vehicle,
    required this.latitude,
    required this.longitude,
  });

  ClinicModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    tell = json["tell"];
    img = json["img"];
    time = json["time"];
    type = json["type"];
    detail = json["detail"];
    vehicle = json["vehicle"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["address"] = this.address;
    data["tell"] = this.tell;
    data["img"] = this.img;
    data["time"] = this.time;
    data["type"] = this.type;
    data["detail"] = this.detail;
    data["vehicle"] = this.vehicle;
    data["latitude"] = this.latitude;
    data["longitude"] = this.longitude;
    return data;
  }
}
