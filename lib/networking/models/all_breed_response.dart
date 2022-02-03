// To parse this JSON data, do
//
//     final allBreedResponse = allBreedResponseFromJson(jsonString);

import 'dart:convert';

AllBreedResponse allBreedResponseFromJson(String str) => AllBreedResponse.fromJson(json.decode(str));

String allBreedResponseToJson(AllBreedResponse data) => json.encode(data.toJson());

class AllBreedResponse {
  AllBreedResponse({
    this.message,
    this.status,
  });

  Map<String, List<String>>? message;
  String? status;

  factory AllBreedResponse.fromJson(Map<String, dynamic> json) => AllBreedResponse(
    message: Map.from(json["message"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": Map.from(message!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "status": status,
  };
}
