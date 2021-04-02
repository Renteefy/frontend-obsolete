import 'package:flutter/widgets.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/pages/components/ListingCard.dart';

class ListingCardBuilder extends StatelessWidget {
  final List<AssetListing> objarr;
  ListingCardBuilder({this.objarr});
  @override
  Widget build(BuildContext context) {
    List<Row> list = [];
    List<ListingCard> childList = [];
    for (int i = 0; i < objarr.length; i++) {
      var obj = objarr[i];
      if ((i + 1) % 2 == 0) {
        childList.add(ListingCard(
            title: obj.title, price: obj.price, interval: obj.interval));
        list.add(Row(
          children: childList,
        ));
        childList = [];
      } else {
        //print(obj);
        childList.add(ListingCard(
            title: obj.title,
            url: obj.url,
            price: obj.price,
            interval: obj.interval));
      }
    }
    if (objarr.length % 2 != 0) {
      list.add(Row(
        children: [
          ListingCard(
              title: objarr[objarr.length - 1].title,
              price: objarr[objarr.length - 1].price,
              url: objarr[objarr.length - 1].url,
              interval: objarr[objarr.length - 1].interval)
        ],
      ));
    }

    return Center(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 8.0,
        runSpacing: 8.0,
        children: list,
      ),
    );
  }
}
