import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  // final String content;
  final Function onTap;

  ProfileTile({
    required this.icon,
    required this.title,
    // required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Icon(
        IconButton(
          onPressed: () => onTap(),
          icon: Icon(icon, size: 32),
        ),
        //   icon,
        //   size: 32,

        // ),
        Text(title, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
