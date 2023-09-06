import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:english_news_app/data/app_exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiServices{
  dynamic jsonData;

  Future<dynamic> getApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      jsonData = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeoutException();
    }

    return jsonData;
  }

  Future<dynamic> postApi(String url, dynamic data) async {
    try {
      final response = await http.post(Uri.parse(url), body: data).timeout(const Duration(seconds: 20));
      jsonData = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on TimeoutException {
      throw RequestTimeoutException();
    }

    return jsonData;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        jsonData = jsonDecode(response.body);
        return jsonData;
      case 201:
        jsonData = jsonDecode(response.body);
        return jsonData;
      case 400:
        throw BadRequestException(message: 'BAD REQUEST - Due to a missing parameter');
      case 401:
        throw UnauthorizedException(message: 'UNAUTHORIZED - Your API key was missing from the request, or was incorrect.');
      case 429:
        throw TooManyRequestsException(message: 'TOO MANY REQUESTS');
      case 500:
        throw ServerErrorException(message: 'SERVER ERROR');
      default:
        throw UnknownException('UNKNOWN ERROR');
    }
  }
}