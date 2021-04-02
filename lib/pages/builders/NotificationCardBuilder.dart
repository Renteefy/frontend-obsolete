import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/NotificationListing.dart';
import 'package:frontend/pages/components/NotificationCard.dart';

class NotificationCardBuilder extends StatelessWidget {
  final List<NotificationListing> objarr;
  NotificationCardBuilder({this.objarr});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: objarr
          .map((e) => NotificationCard(
                notifi: e,
              ))
          .toList(),
    );
  }
}
