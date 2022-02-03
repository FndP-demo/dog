import 'dart:io';
import 'dart:convert';
import 'package:dog/utils/constants.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  Future<dynamic> patch(String url,{var body}) async {
    var responseJson;
    var response;
    try {
      if(body==null){
        response = await http.patch(Uri.parse(constants.baseUrl + url), headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        });
      }else{
        response = await http.patch(Uri.parse(constants.baseUrl + url), headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },body: json.encode(body));
      }

      constants.printLog(response.request);
      responseJson = _response(response);
      constants.printLog(responseJson);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response =
      await http.get(Uri.parse(constants.baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      print(url);
      responseJson = _response(response);
      debugPrint(responseJson);
    } on SocketException {
      throw NoInternetException(constants.noInternet);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(constants.baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException(constants.noInternet);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, var body) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(constants.baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(body),);
      constants.printLog(response.request);
      responseJson = _response(response);
      constants.printLog(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,{var body}) async {
    var responseJson;
    var response;
    try {

      if(body==null){
        response = await http.put(Uri.parse(constants.baseUrl + url),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            });
      }else{
        response = await http.put(Uri.parse(constants.baseUrl + url),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: json.encode(body));
      }
      constants.printLog(response.request);
      responseJson = _response(response);
      constants.printLog(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithToken(String url, var body) async {
    var responseJson;
    try {

      final response = await http.post(Uri.parse(constants.baseUrl + url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: body);
      constants.printLog(response.request);
      responseJson = _response(response);
      constants.printLog(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  dynamic _response(http.Response response) {
    constants.printLog(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        constants.printLog(responseJson);
        return responseJson;
      case 201:
      case 204:
        var responseJson = json.decode(response.body.toString());
        constants.printLog(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      case 401:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw NoInternetException(msg);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 412:
        var responseJson = json.decode(response.body.toString());
        // constants.printLog(responseJson);
        throw BadRequestException (responseJson["meta"]["message"]??"Something went wrong");
      case 500:
        var responseJson = json.decode(response.body.toString());
        var error =
        responseJson["errors"] ?? "";
        var msg = "";
        if (error != "") {
          msg = error["meta"]["message"] ?? "";
        }
        throw BadRequestException(msg!=null?msg: response.body.toString());
    // } else {
    //   throw BadRequestException(response.body.toString());
    // }
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}