import 'package:bsf/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<Map<String, dynamic>> drawerItems = [
    {'icon': FontAwesomeIcons.solidHeart, 'title': 'Favourites'},
    {'icon': FontAwesomeIcons.shoppingCart, 'title': 'Cart'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sanjana Jagani",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Active Status',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: drawerItems
                .map((element) => Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: [
                  Icon(
                    element['icon'],
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    element['title'],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ))
                .toList(),
          ),
          Row(
            children: [
              Icon(Icons.settings, color: Colors.white),
              SizedBox(width: 30),
              Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 30),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: 30),
              Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
