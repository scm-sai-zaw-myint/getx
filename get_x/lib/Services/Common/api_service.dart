
// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:get_x/Services/Common/config.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final http.Client _api;
  final Map<String, String> headers = {
    "x-app-key": Config.xAppKey,
    "Content-Type": Config.contentType
  };
  
  ApiService() : _api = http.Client();

  Future<http.Response> get(String url) async {
    try{
      return await _api.get(Uri.parse(url), headers: headers);
    }catch(e){
      return http.Response(jsonEncode({"code": 400,"data":null, "ok": false, "message": "Error while fetching api."}), 503);
    }
  }
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try{
      return await _api.post(Uri.parse(url),body: jsonEncode(body), headers: headers);
    }catch(e){
      return http.Response(jsonEncode({"code": 400,"data":null, "ok": false, "message": "Error while fetching api."}), 503);
    }
  }
  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try{
      return await _api.put(Uri.parse(url),body: jsonEncode(body), headers: headers);
    }catch(e){
      return http.Response(jsonEncode({"code": 400,"data":null, "ok": false, "message": "Error while fetching api."}), 503);
    }
  }
  Future<http.Response> delete(String url) async {
    try{
      return await _api.delete(Uri.parse(url), headers: headers);
    }catch(e){
      return http.Response(jsonEncode({"code": 400,"data":null, "ok": false, "message": "Error while fetching api."}), 503);
    }
  }
}