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
          obj: obj,
        ));
        list.add(Row(
          children: childList,
        ));
        childList = [];
      } else {
        //print(obj);
        childList.add(ListingCard(
          obj: obj,
        ));
      }
    }
    if (objarr.length % 2 != 0) {
      list.add(Row(
        children: [ListingCard(obj: objarr[objarr.length - 1])],
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
