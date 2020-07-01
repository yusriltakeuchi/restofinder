import 'package:dio/dio.dart';

class ConfigServices {
  static Options getHeaders({String token = ""}) {
    var _headers = Map<String, dynamic>();
    _headers['Accept'] = "application/json";
    if (token != '') {
      _headers['user-key'] = token;
    }

    return Options(headers: _headers);
  }
}
