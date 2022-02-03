// To parse this JSON data, do
//
//     final randomImageResponse = randomImageResponseFromJson(jsonString);

import 'dart:convert';

RandomImageResponse randomImageResponseFromJson(String str) => RandomImageResponse.fromJson(json.decode(str));

String randomImageResponseToJson(RandomImageResponse data) => json.encode(data.toJson());

class RandomImageResponse {
  RandomImageResponse({
    this.message,
    this.status,
  });

  String? message;
  String? status;

  factory RandomImageResponse.fromJson(Map<String, dynamic> json) => RandomImageResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
