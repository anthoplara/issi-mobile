import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/networks/custom_exception.dart';

class ApiWrapper {
  GetStorage localData = GetStorage();

  Future<dynamic> request(String baseUrl, String initial, String method, String route, Map<String, dynamic> data) async {
    dynamic responseJson;

    final headers = <String, dynamic>{};

    var url = baseUrl + route;

    if (method == "get") {
      var param = '';

      Map<String, dynamic> params = data['params'] ?? {};
      params.forEach((k, v) => param += "$k=${v ?? ''}&");

      try {
        Dio dio = Dio();
        dio.options.headers = headers;
        final response = await dio.get("$url?$param");
        responseJson = _response(response);
      } on SocketException {
        throw FetchDataException('Tidak terhubung ke server');
      }
    } else {
      try {
        Dio dio = Dio();
        Map<String, dynamic> body = data['body'] ?? {};
        dio.options.headers = headers;
        FormData formData = FormData.fromMap(body);
        final response = await dio.post(url, data: formData);
        responseJson = _response(response);
      } on SocketException {
        throw FetchDataException('Tidak terhubung ke server');
      }
    }

    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 100: //'Continue'; break;
      case 101: //'Switching Protocols'; break;
      case 200: //'OK'; break;
        var responseJson = response.data;
        return responseJson;
      case 201: //'Created'; break;
      case 202: //'Accepted'; break;
      case 203: //'Non-Authoritative Information'; break;
      case 204: //'No Content'; break;
      case 205: //'Reset Content'; break;
      case 206: //'Partial Content'; break;
      case 300: //'Multiple Choices'; break;
      case 301: //'Moved Permanently'; break;
      case 302: //'Moved Temporarily'; break;
      case 303: //'See Other'; break;
      case 304: //'Not Modified'; break;
      case 305: //'Use Proxy'; break;
      case 400: //'Bad Request'; break;
      case 401: //'Unauthorized'; break;
      case 402: //'Payment Required'; break;
      case 403: //'Forbidden'; break;
      case 404: //'Not Found'; break;
      case 405: //'Method Not Allowed'; break;
      case 406: //'Not Acceptable'; break;
      case 407: //'Proxy Authentication Required'; break;
      case 408: //'Request Time-out'; break;
      case 409: //'Conflict'; break;
      case 410: //'Gone'; break;
      case 411: //'Length Required'; break;
      case 412: //'Precondition Failed'; break;
      case 413: //'Request Entity Too Large'; break;
      case 414: //'Request-URI Too Large'; break;
      case 415: //'Unsupported Media Type'; break;
      case 500: //'Internal Server Error'; break;
      case 501: //'Not Implemented'; break;
      case 502: //'Bad Gateway'; break;
      case 503: //'Service Unavailable'; break;
      case 504: //'Gateway Time-out'; break;
      case 505: //'HTTP Version not supported'; break;
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
