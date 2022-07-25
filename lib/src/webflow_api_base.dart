import 'dart:convert';

import 'package:http/http.dart' as http;

import 'webflow_api_models.dart';
export 'webflow_api_models.dart';

/// The class that communicates with the Webflow API.
/// Expects at least two parameters: token and siteId.
/// These parameters are obrained from the Webflow web dashboard.
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

  /// Retreives all the site's CMS collections
  Future<List<Collection>> collections() async {
    var url = Uri.https(endpoint, "/sites/$siteId/collections");

    var response = await http.get(url, headers: headers);

    List json = jsonDecode(response.body) as List;
    List<Collection> collections =
        json.map((e) => Collection.fromJson(e)).toList();
    return collections;
  }

  /// Retrieves a single CMS collection details, by collection ID
  Future<Collection> collection(String collectionId) async {
    var url = Uri.https(endpoint, "/collections/$collectionId");
    var response = await http.get(url, headers: headers);
    dynamic json = jsonDecode(response.body);
    Collection collection = Collection.fromJson(json);
    return collection;
  }

  // Items

  /// Retrieves all the items in a collection, by collection ID
  Future<ItemsResponse> items(String collectionId,
      {int offset = 0, int limit = 100}) async {
    var url = Uri.https(endpoint, "/collections/$collectionId/items",
        {"offset": offset.toString(), "limit": limit.toString()});

    var response = await http.get(url, headers: headers);

    dynamic json = jsonDecode(response.body);
    ItemsResponse itemsResponse = ItemsResponse.fromJson(json);
    return itemsResponse;
  }

  /// Retrieves a CMS Item, by collection ID and Item ID
  Future<ItemsResponse> item({
    required String collectionId,
    required String itemId,
  }) async {
    Uri url = Uri.https(endpoint, "/collections/$collectionId/items/$itemId");

    http.Response response = await http.get(url, headers: headers);

    return ItemsResponse.fromJson(jsonDecode(response.body));
  }

  /// Creates a new CMS in a collection
  Future<Item> createItem({
    required String collectionId,
    Map<String, dynamic> fields = const {},
    bool live = false,
    bool archived = false,
    bool draft = true,
  }) async {
    var url = Uri.https(endpoint, "/collections/$collectionId/items", {
      "live": live.toString(),
    });

    http.Response response = await http.post(url,
        headers: headers,
        body: jsonEncode(
          {
            "fields": {
              "_archived": archived,
              "_draft": draft,
              ...fields,
            }
          },
        ));

    return Item.fromJson(jsonDecode(response.body));
  }

  /// Removes (deletes) a CMS collection item, by item ID
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

  /// Updates the fields of a CMS collection item
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
