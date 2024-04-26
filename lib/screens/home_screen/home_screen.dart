import 'dart:async';
import 'package:bsf/core/utils/ui_helper.dart';
import 'package:bsf/data.dart';
import 'package:bsf/screens/home_screen/widgets/vendor_card.dart';
import 'package:bsf/screens/vendor_screen/macd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bsf/core/animations/animations.dart';
import 'package:bsf/core/animations/fade_animation.dart';
import 'package:bsf/core/animations/slide_animation.dart';
import 'package:bsf/core/utils/navigation.dart';
import 'package:bsf/core/widgets/custom_widgets.dart';
import 'package:bsf/screens/home_screen/widgets/category_list_view.dart';
import 'package:bsf/screens/home_screen/widgets/clipped_container.dart';

class Vendor {
  final String imagePath;
  final String name;
  final double rating;

  Vendor({
    required this.imagePath,
    required this.name,
    required this.rating,
  });
}

final List<Vendor> vendorList = [
  Vendor(
    imagePath: "assets/images/logo/macd.png",
    name: "MacDonald's",
    rating: 4.5,
  ),
  Vendor(
    imagePath: "assets/images/logo/bk.png",
    name: "Burger King",
    rating: 4.8,
  ),
  Vendor(
    imagePath: "assets/images/logo/dominos.png",
    name: "Domino's Pizza",
    rating: 4.3,
  ),
  Vendor(
    imagePath: "assets/images/logo/qc.png",
    name: "Queasy Cheesy",
    rating: 4.8,
  ),
  Vendor(
    imagePath: "assets/images/logo/dnkn.png",
    name: "Dunkin' Donuts",
    rating: 4.2,
  ),
  Vendor(
    imagePath: "assets/images/logo/kk.png",
    name: "Krispy Kreme",
    rating: 4.0,
  ),
  Vendor(
    imagePath: "assets/images/logo/sub.png",
    name: "Subway",
    rating: 4.3,
  ),
  Vendor(
    imagePath: "assets/images/logo/chesecake-logo.png",
    name: "The Cheesecake Factory",
    rating: 3.8,
  ),
];

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _height;
  int _selectedIndex = 0;
  final _duration = const Duration(milliseconds: 750);
  final _pseudoDuration = const Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SlideAnimation(
              begin: const Offset(0, 400),
              duration: _duration,
              child: AnimatedContainer(
                height: _height,
                duration: _duration,
                padding: EdgeInsets.only(bottom: 20),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomAppBar(
                        hasBackButton: false,
                        showLogoutButton: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Hi, ',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                '${FirebaseAuth.instance.currentUser?.displayName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'abcd.dart');
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'DELIVER TO ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 12, height: 1.5),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'MY HOME',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: '\u2304',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ClippedContainer(
                        child: Column(
                          children: [
                            CategoryListView(
                              selectedIndex: _selectedIndex,
                              onCategoryTap: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            _selectedIndex == 1
                                ? VendorListView(
                              vendors: burgerVendors,
                            )
                                : _selectedIndex == 2
                                ? VendorListView(
                              vendors: pizzaVendors,
                            )
                                : _selectedIndex == 3
                                ? VendorListView(
                              vendors: dessertVendors,
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _height = 0;
    setState(() {});
    Timer(const Duration(milliseconds: 50), () {
      _animateContainerFromTopToBottom();
    });
  }

  Future<void> _animateContainerFromTopToBottom() async {
    await Future.delayed(_pseudoDuration);
    _height = MediaQuery.of(context).size.height;
    setState(() {});
  }
}

class CustomAppBar extends StatelessWidget {
  final bool hasBackButton;
  final bool showLogoutButton;

  const CustomAppBar({
    required this.hasBackButton,
    required this.showLogoutButton,
  });

  @override
  Widget build(BuildContext context) {
    // Your CustomAppBar implementation
    return Container(); // Placeholder, replace with your CustomAppBar
  }
}

class CategoryListView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategoryTap;

  const CategoryListView({
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    // Your CategoryListView implementation
    return Container(); // Placeholder, replace with your CategoryListView
  }
}

class VendorListView extends StatelessWidget {
  final List<Map<String, dynamic>> vendors;

  const VendorListView({
    required this.vendors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vendors.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        return ListTile(
          leading: Image.asset(vendor['imagePath']),
          title: Text(vendor['name']),
          subtitle: Text('Rating: ${vendor['rating']}'),
          onTap: () {
            // Handle vendor tap
          },
        );
      },
    );
  }
}

const List<Map<String, dynamic>> burgerVendors = [
  {
    "imagePath": "assets/images/logo/macd.png",
    "name": "MacDonald's",
    "rating": 4.5,
  },
  {
    "imagePath": "assets/images/logo/bk.png",
    "name": "Burger King",
    "rating": 4.8,
  },
];

const List<Map<String, dynamic>> pizzaVendors = [
  {
    "imagePath": "assets/images/logo/dominos.png",
    "name": "Domino's Pizza",
    "rating": 4.3,
  },
  {
    "imagePath": "assets/images/logo/qc.png",
    "name": "Queasy Cheesy",
    "rating": 4.8,
  },
  {
    "imagePath": "assets/images/logo/sub.png",
    "name": "Subway",
    "rating": 4.3,
  },
];

const List<Map<String, dynamic>> dessertVendors = [
  {
    "imagePath": "assets/images/logo/dnkn.png",
    "name": "Dunkin' Donuts",
    "rating": 4.2,
  },
  {
    "imagePath": "assets/images/logo/kk.png",
    "name": "Krispy Kreme",
    "rating": 4.0,
  },
  {
    "imagePath": "assets/images/logo/chesecake-logo.png",
    "name": "The Cheesecake Factory",
    "rating": 3.8,
  },
];