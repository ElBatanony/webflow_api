class Collection {
  String id, lastUpdated, createdOn, name, slug, singularName;
  List<Field> fields;

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        lastUpdated = json["lastUpdated"],
        createdOn = json["createdOn"],
        name = json['name'],
        slug = json['slug'],
        singularName = json['singularName'],
        fields = ((json["fields"] ?? []) as List)
            .map((e) => Field.fromJson(e))
            .toList();
}

class Field {
  String id, type, slug, name;
  bool editable, required;

  Field.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        editable = json['editable'],
        required = json['required'],
        type = json['type'],
        slug = json['slug'],
        name = json['name'];
}

class Item {
  String id, collectionId, name, slug;
  bool archived, draft;
  Map<String, dynamic> json;

  Item.fromJson(this.json)
      : archived = json['_archived'],
        draft = json['_draft'],
        id = json['_id'],
        collectionId = json['_cid'],
        name = json['name'],
        slug = json['slug'];
}

class ItemsResponse {
  int count, limit, offset, total;
  List<Item> items;

  ItemsResponse.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        limit = json['limit'],
        offset = json['offset'],
        total = json['total'],
        items = ((json["items"] ?? []) as List)
            .map((e) => Item.fromJson(e))
            .toList();
}
