import 'package:flutter/material.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/pages/components/ListingCard.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/AssetsHttpService.dart';

// - AssetCatalogPage - All assets will be displayed here
// Functionality: This renders the Scaffold and calls in the ListingCardBuilder Widget
// - The  ListingCardBuilder widget renders all the assets on screen. It uses very basic algorithm to
// render 2 items in one row and return this an array of such rows back to this page, where it is rendered in a scroll view
// - This page loads data lazily, to save resources.
// - The json required for the cards to display(for now, will change):
//
// {     "url": "https://via.placeholder.com/150",
//       "title": "Asset1",
//       "price": "10",
//       "interval": "per day"
// }

// fetch function is where the network call resides.
// So, fetchfive() does 5 network calls, which is inefficient
// TODO:
// 1. Gotta refactor fetch and fetchfive function to make one call to server and get 5 unique asset items
// 2. Build Models for the json which is flowing in (done)
// 3. Convert the ListCardBuilder to use iterable

class AssetCatalogPage extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _AssetCatalogPageState createState() => _AssetCatalogPageState();
}

class _AssetCatalogPageState extends State<AssetCatalogPage> {
  ScrollController scrollController = new ScrollController();
  final assetService = AssetsHttpService();
  // Skip is basically the number of entries that have to be skipped in the database call, should be incremented after every call
  int skip = 0;

  @override
  void initState() {
    super.initState();

    fetch(5);
    fetchAll();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print(scrollController.position.pixels);
        fetch(5);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<AssetListing> res = [];
  List<AssetListing> searchRes = [];
  List<AssetListing> allAssets = [];

  void fetch(int limit) async {
    List<AssetListing> tmp = await assetService.getAssets(skip, limit);
    setState(() {
      res.addAll(tmp);
      // increment skip here
      skip = skip + 5;
    });
  }

  void fetchAll() async {
    List<AssetListing> tmp = await assetService.getAllAssets();
    setState(() {
      allAssets.addAll(tmp);
    });
  }

  void sortMadoAppa(String property) {
    switch (property) {
      case "name_a":
        setState(() {
          res.sort(
              (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
          searchRes.sort(
              (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        });
        break;
      case "name_b":
        setState(() {
          res.sort(
              (b, a) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
          searchRes.sort(
              (b, a) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        });
        break;
      case "price_a":
        setState(() {
          res.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
          searchRes
              .sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
        });
        break;
      case "price_b":
        setState(() {
          res.sort((b, a) => int.parse(a.price).compareTo(int.parse(b.price)));
          searchRes
              .sort((b, a) => int.parse(a.price).compareTo(int.parse(b.price)));
        });
        break;
      case "interval":
        setState(() {
          res.sort((a, b) => a.interval.compareTo(b.interval));
          searchRes.sort((a, b) => a.interval.compareTo(b.interval));
        });
        break;
      case "date_a":
        setState(() {
          res.sort((b, a) => a.date.compareTo(b.date));
          searchRes.sort((b, a) => a.date.compareTo(b.date));
        });
        break;
      case "date_b":
        setState(() {
          res.sort((a, b) => a.date.compareTo(b.date));
          searchRes.sort((a, b) => a.date.compareTo(b.date));
        });
        break;
      default:
        return;
    }
  }

  bool searched = false;

  onSearchTextChanged(String text) async {
    searchRes.clear();
    searched = true;
    if (text.isEmpty) {
      searched = false;
      setState(() {});
      return;
    }
    allAssets.forEach((asset) {
      if (asset.title.toLowerCase().contains(text.toLowerCase()) ||
          asset.price.contains(text)) searchRes.add(asset);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Add sorting code here
    void onSortPressed() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Name: A to Z"),
                    leading: Icon(Icons.ac_unit),
                    onTap: () => setState(() {
                      sortMadoAppa("name_a");
                      Navigator.of(context).pop();
                    }),
                  ),
                  ListTile(
                    title: Text("Name: Z to A"),
                    leading: Icon(Icons.ac_unit),
                    onTap: () => setState(() {
                      sortMadoAppa("name_b");
                      Navigator.of(context).pop();
                    }),
                  ),
                  ListTile(
                    title: Text("Price: Low to High"),
                    leading: Icon(Icons.ac_unit),
                    onTap: () => setState(() {
                      sortMadoAppa("price_a");
                      Navigator.of(context).pop();
                    }),
                  ),
                  ListTile(
                    title: Text("Price: High to Low"),
                    leading: Icon(Icons.ac_unit),
                    onTap: () => setState(() {
                      sortMadoAppa("price_b");
                      Navigator.of(context).pop();
                    }),
                  ),
                  ListTile(
                    title: Text("Interval"),
                    onTap: () => setState(() {
                      sortMadoAppa("interval");
                      Navigator.of(context).pop();
                    }),
                    leading: Icon(Icons.ac_unit),
                  ),
                  ListTile(
                    title: Text("Date (Newest to Oldest)"),
                    onTap: () => setState(() {
                      sortMadoAppa("date_a");
                      Navigator.of(context).pop();
                    }),
                    leading: Icon(Icons.ac_unit),
                  ),
                  ListTile(
                    title: Text("Date (Oldest to Newest)"),
                    onTap: () => setState(() {
                      sortMadoAppa("date_b");
                      Navigator.of(context).pop();
                    }),
                    leading: Icon(Icons.ac_unit),
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Text("Rent ",
                  style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w900)),
              Text("Assets",
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900)),
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_none_rounded),
                iconSize: 30,
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                })
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Search Asset',
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () => onSortPressed()),
                  ],
                ),
                SizedBox(height: 50),
                Flexible(
                  child: GridView.builder(
                      controller: scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: (searched) ? searchRes.length : res.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ListingCard(
                          obj: (searched) ? searchRes[index] : res[index],
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
