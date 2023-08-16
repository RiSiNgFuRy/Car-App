import 'dart:convert';
import 'dart:io';

import 'package:car_app/data/app_exceptions.dart';
import 'package:car_app/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

Duration timeOutTime = const Duration(seconds: 5);

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async{
    dynamic jsonResponse;
    try {
      final response = await http.get(
          Uri.parse(url)
      ).timeout(timeOutTime);

      jsonResponse = parseResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic jsonResponse;
    try {
      final response = await http.post(
          Uri.parse(url),
          body: data
      ).timeout(timeOutTime);

      jsonResponse = parseResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return jsonResponse;
  }

  dynamic parseResponse(http.Response response) {
    switch(response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw DataNotFoundException();
      default:
        throw FetchDataException("Unhandled response code type occurred (statusCode: ${response.statusCode.toString()})");
    }
  }
}