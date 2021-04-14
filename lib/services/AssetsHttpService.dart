import 'dart:convert';
import 'dart:ui';
// import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/models/NotificationListing.dart';

class AssetsHttpService {
  final String url = env['SERVER_URL'];
  final store = new FlutterSecureStorage();

  Future<List<AssetListing>> getAssets(int skip, int limit) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "assets/getsome/$skip/$limit"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }

    List<AssetListing> assets = [];

    for (var asset in jsonData["assets"]) {
      final tmp = AssetListing.fromJson(asset);
      assets.add(tmp);
    }

    return assets;
  }

  Future<List<AssetListing>> getAllAssets() async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "assets/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }

    List<AssetListing> assets = [];

    for (var asset in jsonData["assets"]) {
      final tmp = AssetListing.fromJson(asset);
      assets.add(tmp);
    }

    return assets;
  }

  Future<List<dynamic>> getSingleAsset(String assetID) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "assets/asset/$assetID"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);
    var notifi;

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }

    final asset = SingleAsset.fromJson(jsonData["assetResponse"]);
    if (jsonData["notifiResponse"] != null) {
      notifi = NotificationListing.fromJson(jsonData["notifiResponse"]);
    } else {
      notifi = "";
    }

    return [asset, notifi];
  }

  Future<int> postAsset(String title, String description, picture, String price,
      String interval, String category) async {
    var request = http.MultipartRequest("POST", Uri.https(url, "assets"));

    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["price"] = price;
    request.fields["interval"] = interval;
    request.fields["category"] = category;
    request.fields["owner"] = await store.read(key: "username");

    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: "jwt");
    if (picture != null) {
      request.files
          .add(await http.MultipartFile.fromPath('AssetImage', picture));
    }
    request.headers.addAll(
        {'Content-Type': 'multipart/form-data', 'Authorization': value});

    var response = await request.send();
    var respStr = await http.Response.fromStream(response);
    return (respStr.statusCode);
  }

  Future<int> patchAsset(String title, String description, picture,
      String price, String interval, String category, String assetID) async {
    var request =
        http.MultipartRequest("PATCH", Uri.https(url, "assets/asset/$assetID"));

    request.fields["title"] = title;
    request.fields["description"] = description;
    request.fields["price"] = price;
    request.fields["interval"] = interval;
    request.fields["category"] = category;
    request.fields["owner"] = await store.read(key: "username");

    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: "jwt");
    if (picture != null) {
      request.files
          .add(await http.MultipartFile.fromPath('AssetImage', picture));
    }
    request.headers.addAll(
        {'Content-Type': 'multipart/form-data', 'Authorization': value});

    var response = await request.send();
    var respStr = await http.Response.fromStream(response);
    print(respStr.body);
    return (respStr.statusCode);
  }

  Future<List<SingleAsset>> getUserAssets() async {
    String value = await store.read(key: "jwt");
    String username = await store.read(key: "username");

    var data = await http.get(Uri.https(url, "assets/user/$username"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }
    var jsonData = json.decode(data.body);

    List<SingleAsset> assets = [];
    for (var asset in jsonData["assets"]) {
      asset["renter"] = "aise hi likh diya hai";
      final tmp = SingleAsset.fromJson(asset);
      assets.add(tmp);
    }
    return assets;
  }

  Future<List<SingleAsset>> getUserRentedAssets() async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "assets/userRented/"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }
    var jsonData = json.decode(data.body);

    List<SingleAsset> assets = [];
    for (var asset in jsonData["assets"]) {
      asset["renter"] = "aise hi likh diya hai";
      final tmp = SingleAsset.fromJson(asset);
      assets.add(tmp);
    }
    return assets;
  }
}
