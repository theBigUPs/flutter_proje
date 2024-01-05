import 'package:flutter/material.dart';

class Character with ChangeNotifier {
  String name;
  String status;
  String species;
  String originalLocationName;
  String lastLocationName;
  String imgURl;

  Character.fromMap(Map<String, dynamic> map)
      //List<dynamic>
      : name = (map["name"]),
        status = map["status"] ?? "unknown",
        species = map["species"] ?? "unknown",
        originalLocationName =
            (map["origin"] as Map<String, dynamic>)["name"] ?? "unknown",
        lastLocationName =
            (map["location"] as Map<String, dynamic>)["name"] ?? "unknown",
        imgURl = map["image"] ?? "";
}
