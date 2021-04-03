import 'dart:convert';
// import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/AssetListing.dart';

class AssetsHttpService {
  final String url = env['SERVER_URL'];
  // final String url = "127.0.0.1:5000";
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
      final tmp = AssetListing(
          assetID: asset["assetID"],
          title: asset["title"],
          price: asset["price"],
          interval: asset["interval"],
          url: asset["url"]);

      assets.add(tmp);
    }

    return assets;
  }

  Future<SingleAsset> getSingleAsset(String assetID) async {
    String value = await store.read(key: "jwt");

    var data = await http.get(Uri.https(url, "assets/asset/$assetID"),
        headers: {'Content-Type': 'application/json', 'Authorization': value});
    var jsonData = json.decode(data.body);

    if (data.statusCode != 200) {
      print("Auth Failed, please login");
      throw "Unable to retrieve assetCatalog.";
    }

    final asset = SingleAsset(
        assetID: jsonData["assetID"],
        title: jsonData["title"],
        price: jsonData["price"],
        interval: jsonData["interval"],
        url: jsonData["url"],
        description: jsonData["description"]);

    return asset;
  }
}
