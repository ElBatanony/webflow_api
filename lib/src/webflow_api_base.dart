import 'dart:convert';

import 'package:http/http.dart' as http;

import 'webflow_api_models.dart';
export 'webflow_api_models.dart';

class Webflow {
  String endpoint;
  String token;
  String version;
  String siteId;
  Map<String, String>? headers;

  Webflow({
    required this.token,
    required this.siteId,
    this.version = "1.0.0",
    this.endpoint = "api.webflow.com",
  }) {
    headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "accept-version": version,
      "Content-Type": "application/json",
    };
  }

  // Collections

  Future<List<Collection>> collections() async {
    var url = Uri.https(endpoint, "/sites/$siteId/collections");

    var response = await http.get(url, headers: headers);

    List json = jsonDecode(response.body) as List;
    List<Collection> collections =
        json.map((e) => Collection.fromJson(e)).toList();
    return collections;
  }

  Future<Collection> collection(String collectionId) async {
    var url = Uri.https(endpoint, "/collections/$collectionId");
    var response = await http.get(url, headers: headers);
    dynamic json = jsonDecode(response.body);
    Collection collection = Collection.fromJson(json);
    return collection;
  }

  // Items

  Future<ItemsResponse> items(String collectionId,
      {int offset = 0, int limit = 100}) async {
    var url = Uri.https(endpoint, "/collections/$collectionId/items",
        {"offset": offset.toString(), "limit": limit.toString()});

    var response = await http.get(url, headers: headers);

    dynamic json = jsonDecode(response.body);
    ItemsResponse itemsResponse = ItemsResponse.fromJson(json);
    return itemsResponse;
  }
  Future<int> removeItem({
    required String collectionId,
    required String itemId,
    bool live = false,
  }) async {
    Uri url = Uri.https(endpoint, "/collections/$collectionId/items/$itemId", {
      "live": live.toString(),
    });

    http.Response response = await http.delete(url, headers: headers);

    dynamic json = jsonDecode(response.body);
    int deletedCount = json['deleted'];
    return deletedCount;
  }

  Future<Item> updateItem({
    required String collectionId,
    required String itemId,
    Map<String, dynamic> fields = const {},
    bool live = false,
  }) async {
    Uri url = Uri.https(endpoint, "/collections/$collectionId/items/$itemId", {
      "live": live.toString(),
    });

    http.Response response = await http.patch(url,
        headers: headers, body: jsonEncode({"fields": fields}));

    return Item.fromJson(jsonDecode(response.body));
  }
}
