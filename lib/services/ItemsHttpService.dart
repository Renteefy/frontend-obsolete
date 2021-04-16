import 'dart:convert';
// import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:frontend/models/NotificationListing.dart';

class ItemsHttpService {
  final String url = env['SERVER_URL'];
  final store = new FlutterSecureStorage();

  Future<List<ItemListing>> getItems(int skip, int limit, String item) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "${item}s/getsome/$skip/$limit"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Catalog.";
    }

    List<ItemListing> items = [];

    for (var item in jsonData["items"]) {
      final tmp = ItemListing.fromJson(item);
      items.add(tmp);
    }

    return items;
  }

  Future<List<ItemListing>> getAllItems(String item) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "${item}s/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Catalog.";
    }

    List<ItemListing> items = [];

    for (var tmpItem in jsonData["items"]) {
      final tmp = ItemListing.fromJson(tmpItem);
      items.add(tmp);
    }

    return items;
  }

  Future<List<dynamic>> getSingleItem(String itemID, String item) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "${item}s/$item/$itemID"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);
    var notifi;

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Catalog.";
    }

    final tmpItem = SingleItem.fromJson(jsonData["itemResponse"]);
    if (jsonData["notifiResponse"] != null) {
      notifi = NotificationListing.fromJson(jsonData["notifiResponse"]);
    } else {
      notifi = "";
    }

    return [tmpItem, notifi];
  }

  Future<int> postItem(String title, String description, picture, String price,
      String interval, String category, String item) async {
    var request = http.MultipartRequest("POST", Uri.https(url, "${item}s"));

    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["price"] = price;
    request.fields["interval"] = interval;
    request.fields["category"] = category;
    request.fields["owner"] = await store.read(key: "username");

    String value = await store.read(key: "jwt");
    if (picture != null) {
      request.files
          .add(await http.MultipartFile.fromPath('${item}Image', picture));
    }
    request.headers.addAll(
        {'Content-Type': 'multipart/form-data', 'Authorization': value});

    var response = await request.send();
    var respStr = await http.Response.fromStream(response);
    return (respStr.statusCode);
  }

  Future<int> patchItem(String title, String description, picture, String price,
      String interval, String category, String itemID, String item) async {
    var request = http.MultipartRequest(
        "PATCH", Uri.https(url, "${item}s/$item/$itemID"));

    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["price"] = price;
    request.fields["interval"] = interval;
    request.fields["category"] = category;
    request.fields["owner"] = await store.read(key: "username");

    String value = await store.read(key: "jwt");
    if (picture != null) {
      request.files
          .add(await http.MultipartFile.fromPath('${item}Image', picture));
    }
    request.headers.addAll(
        {'Content-Type': 'multipart/form-data', 'Authorization': value});

    var response = await request.send();
    var respStr = await http.Response.fromStream(response);
    return (respStr.statusCode);
  }

  Future<List<SingleItem>> getUserItems(String item) async {
    String value = await store.read(key: "jwt");
    String username = await store.read(key: "username");

    var data = await http.get(Uri.https(url, "${item}s/user/$username"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }
    var jsonData = json.decode(data.body);

    List<SingleItem> items = [];
    for (var tmpItem in jsonData["items"]) {
      tmpItem["renter"] = "aise hi likh diya hai";
      final tmp = SingleItem.fromJson(tmpItem);
      items.add(tmp);
    }
    return items;
  }

  Future<List<SingleItem>> getUserRentedItems(String item) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "${item}s/userRented/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve Catalog.";
    }
    var jsonData = json.decode(data.body);

    List<SingleItem> items = [];
    for (var tmpItem in jsonData["items"]) {
      tmpItem["renter"] = "aise hi likh diya hai";
      final tmp = SingleItem.fromJson(tmpItem);
      items.add(tmp);
    }
    return items;
  }
}
