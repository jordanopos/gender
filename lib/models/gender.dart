// To parse this JSON data, do
//
//     final gender = genderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenderResult genderFromJson(String str) => GenderResult.fromJson(json.decode(str));

String genderToJson(GenderResult data) => json.encode(data.toJson());

class GenderResult {
    GenderResult({
        @required this.name,
        @required this.gender,
        @required this.probability,
        @required this.count,
    });

    String name;
    String gender;
    double probability;
    int count;

    factory GenderResult.fromJson(Map<String, dynamic> json) => GenderResult(
        name: json["name"],
        gender: json["gender"],
        probability: json["probability"].toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "probability": probability,
        "count": count,
    };
}
