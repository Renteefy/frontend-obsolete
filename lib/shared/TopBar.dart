import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TopBar extends PreferredSize {
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            icon: Icon(Icons.notifications_none_rounded),
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            })
      ],
    );
  }
}
