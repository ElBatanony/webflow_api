import 'package:webflow_api/webflow_api.dart';

const siteId = "insert Site ID";
const authToken = "insert Auth Token";

void main() async {
  Webflow webflow = Webflow(token: authToken, siteId: siteId);

  const collectionId = "insert a collection ID";

  // List all Site Collections
  List<Collection> collections = await webflow.collections();
  print(collections[0].id);
  print(collections[0].fields);

  // Retreive a collection by ID
  Collection collection = await webflow.collection(collectionId);
  print(collection.name);
  print(collection.fields[0].name);
  print(collection.fields[0].id);

  // Fetch collection items with limits and offsets
  ItemsResponse itemResponse =
      await webflow.items(collectionId, limit: 3, offset: 2);
  print(itemResponse.count);
  print(itemResponse.total);
  print(itemResponse.items[0].name);
  print(itemResponse.items[0].id);
  print(itemResponse.items[0].slug);
  print(itemResponse.items[0].json);

  // Fetch an item by ID
  const itemId = "insert an item ID";
  ItemsResponse fetchedItem =
      await webflow.item(collectionId: collectionId, itemId: itemId);
  print(fetchedItem.items[0].name);
  print(fetchedItem.items[0].slug);

  // Create a new collection item
  Item newItem = await webflow.createItem(
      collectionId: collectionId, fields: {"name": "insert new item name"});
  print(newItem.id);
  print(newItem.name);
  print(newItem.json);

  // Remove an item by ID
  int removedCount =
      await webflow.removeItem(collectionId: collectionId, itemId: itemId);
  print(removedCount);

  // Update an item's fields
  Item updatedItem = await webflow.updateItem(
      collectionId: collectionId,
      itemId: itemId,
      fields: {"name": "insert updated item name"});
  print(updatedItem.json);
}
