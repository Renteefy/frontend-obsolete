import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/components/NotificationCard.dart';

class NotificationCardBuilder extends StatelessWidget {
  final List<Map<String, String>> objarr;
  NotificationCardBuilder({this.objarr});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: objarr
          .map((e) => NotificationCard(
                rentee: e["rentee"],
                status: e["status"],
                title: e["title"],
                url: e["url"],
              ))
          .toList(),
    );
  }
}
