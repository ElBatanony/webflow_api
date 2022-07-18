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
