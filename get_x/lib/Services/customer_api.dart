import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_x/Services/Common/api_service.dart';
import 'package:get_x/Services/Common/config.dart';
import 'package:get_x/models/customer.dart';

class CustomerAPI {
  final ApiService api;
  CustomerAPI() : api = ApiService();

  Future<List<Customer>> getCustomer(int? page) async {
    Uri url = page != null
        ? Uri.parse("${Config.url}/customers?page=$page")
        : Uri.parse("${Config.url}/customers");

    final response = await api.get(url);
    final body = json.decode(response.body);
    APIResponse apiResponse = APIResponse.parseJson(body);
    final listbody = apiResponse.data as List<dynamic>;
    List<Customer> customerLists =
        listbody.map((e) => Customer.fromJson(e)).toList();
    return customerLists;
  }

  Future<Customer?> createCustomer(Customer customer) async {
    final response = await api.post(Uri.parse("${Config.url}/customers"),
        body: jsonEncode(customer.toJson()));
    final body = (json.decode(response.body));
    APIResponse apiResponse = APIResponse.parseJson(body);
    if (!apiResponse.ok) {
      return null;
    }
    final data = apiResponse.data as Map<String, dynamic>;
    Customer c = Customer.fromJson(data);
    return c;
  }

  Future<Customer?> updateCustomer(Customer customer) async {
    final response = await api.put(
        Uri.parse("${Config.url}/customers/${customer.id}"),
        body: jsonEncode(customer.toJson()));
    final body = (json.decode(response.body));
    APIResponse apiResponse = APIResponse.parseJson(body);
    if (!apiResponse.ok) {
      return null;
    }
    final data = apiResponse.data as Map<String, dynamic>;
    Customer c = Customer.fromJson(data);
    return c;
  }

  Future<bool> deleteCustomer(int id) async {
    final response = await api.delete(Uri.parse("${Config.url}/customers/$id"));
    final body = (json.decode(response.body));
    APIResponse apiResponse = APIResponse.parseJson(body);
    return apiResponse.ok;
  }

  Future<bool> patchDeleteCustomer(List<int> ids) async {
    String items = ids.join(",");
    final response =
        await api.delete(Uri.parse("${Config.url}/customers?items=${(items)}"));
    final body = json.decode(response.body);
    APIResponse apiResponse = APIResponse.parseJson(body);
    return apiResponse.ok;
  }
}

class APIResponse {
  int code;
  Object? data;
  bool ok;
  String message;
  Pagination? pagination;

  APIResponse(
      {required this.code,
      required this.data,
      required this.ok,
      required this.message});

  factory APIResponse.parseJson(Map<String, dynamic> json) {
    final api = APIResponse(
      code: json["code"],
      data: json["data"],
      ok: json["ok"],
      message: json["message"],
    );
    if (json["pagination"] != null || json["pagination"]) {
      api.pagination = Pagination.parseJson(json["pagination"]);
    }
    return api;
  }
}

class Pagination {
  String next;
  String previous;
  int limit;
  int offset;
  int page;
  int size;

  Pagination(
      {required this.next,
      required this.previous,
      required this.limit,
      required this.offset,
      required this.page,
      required this.size});

  factory Pagination.parseJson(Map<String, dynamic> json) {
    return Pagination(
        next: json["next"],
        previous: json["previous"],
        limit: json["limit"],
        offset: json["offset"],
        page: json["page"],
        size: json["size"]);
  }
}
