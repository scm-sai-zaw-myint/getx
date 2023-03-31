
// ignore_for_file: constant_identifier_names

import 'package:get_x/Services/Common/config.dart';
import 'package:http/http.dart' as http;


// const String PROD_URL = "https://flutterapidemo.onrender.com/api";

class ApiService extends http.BaseClient{
  final http.Client _inner;
  ApiService()
      : _inner = http.Client();


  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Set headers for cross-origin requests
    request.headers['Access-Control-Allow-Origin'] = '*';
    request.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS, PUT, DELETE';
    request.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization';

    request.headers['x-app-key'] = Config.xAppKey;
    request.headers['Content-Type'] = "application/json";
    return _inner.send(request);
  }
}