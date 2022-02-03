// To parse this JSON data, do
//
//     final imageByBreedResponse = imageByBreedResponseFromJson(jsonString);

import 'dart:convert';

ImageByBreedResponse imageByBreedResponseFromJson(String str) => ImageByBreedResponse.fromJson(json.decode(str));

String imageByBreedResponseToJson(ImageByBreedResponse data) => json.encode(data.toJson());

class ImageByBreedResponse {
  ImageByBreedResponse({
    this.message,
    this.status,
  });

  List<String>? message;
  String? status;

  factory ImageByBreedResponse.fromJson(Map<String, dynamic> json) => ImageByBreedResponse(
    message: List<String>.from(json["message"].map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message!.map((x) => x)),
    "status": status,
  };
}
