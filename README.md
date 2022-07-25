# Webflow API

This Webflow API package is aimed to facilitate communicating with the Webflow Content Management System (CMS).

The package could be used to develop admin apps to manage Webflow sites' content, e.g., blogs, events.

The package communicates with the Webflow API via the HTTPS methods.
The design of the package is inspired by the official [Webflow API npm package](https://www.npmjs.com/package/webflow-api).

This package is not officially supported by Webflow.

## Features

The package provides functions to:

- Fetch collections
- Fetch a collection by collection ID
- Fetch items in a collection
- Fetch a collection item by item ID
- Create a new collection item
- Delete a collection item
- Update the fields of an item

## Getting started

To set up the package, first install the package.

```cmd
flutter pub add webflow_api
```

1. Then generate an Webflow API token.
You can find instructions in the official Webflow documentation [here](https://university.webflow.com/lesson/intro-to-the-webflow-api).

1. Retreive the Webflow project ID (Site ID) from the Webflow project settings dashboard.

1. Set up the Webflow object.

```dart
import 'package:webflow_api/webflow_api.dart';

const siteId = "insert site ID here";
const authToken = "insert auth token here";

void main() async {
  Webflow webflow = Webflow(token: authToken, siteId: siteId);
}
```

The official CMS API reference can be found [here](https://developers.webflow.com/).
Note that not all the API methods are currently implemented in this package.

## Usage

### Setup

```dart
const siteId = "insert site ID here";
const authToken = "insert auth token here";
Webflow webflow = Webflow(token: authToken, siteId: siteId);
```

### Fetch all collections

```dart
// Fetch all the CMS Collections 
List<Collection> collections = await webflow.collections();
// Display the ID and fields of the first collection
print(collections[0].id);
print(collections[0].fields);
```

### Fetch Item by ID

```dart
// Fetch an item from a collection by ID
const collectionId = "insert collection ID";
const itemId = "insert item ID";
ItemsResponse fetchedItem = await webflow.item(collectionId: collectionId, itemId: itemId);
// Print fetched item name and slug
print(fetchedItem.items[0].name);
print(fetchedItem.items[0].slug);
```

## Additional information

Package developed by [Ahmed ElBatanony](https://github.com/elbatanony),
as part of a Flutter course at Innopolis University.
