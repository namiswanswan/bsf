import 'package:flutter/material.dart';
import 'package:bsf/core/utils/ui_helper.dart';
import 'package:bsf/data.dart';

class CategoryListView extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onCategoryTap;

  const CategoryListView({
    Key? key,
    required this.selectedIndex,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: rh(120),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: space2x),
        scrollDirection: Axis.horizontal,
        itemCount: categoryIconList.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            name: name[index],
            backgroundColor: widget.selectedIndex == index
                ? Colors.white
                : const Color(0xFFFADFCB),
            icon: Image.asset(
              categoryIconList[index],
              width: rw(55),
              height: rh(45),
            ),
            onTap: () {
              widget.onCategoryTap(index); // Invoke the onTap callback
            },
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String name;
  final Color backgroundColor;
  final VoidCallback onTap; // Add onTap callback

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: GestureDetector( // Wrap with GestureDetector to enable onTap
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: rf(30),
              backgroundColor: backgroundColor,
              child: icon,
            ),
            SizedBox(
              height: rf(space1x),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: rf(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VendorListView extends StatelessWidget {
  final List<Map<String, dynamic>> vendors;

  const VendorListView({Key? key, required this.vendors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: vendors
            .map(
              (vendor) => VendorItem(
            imagePath: vendor['imagePath'],
            name: vendor['name'],
            rating: vendor['rating'],
          ),
        )
            .toList(),
      ),
    );
  }
}

class VendorItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final double rating;

  const VendorItem({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: rw(100),
            height: rh(100),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Rating: $rating',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Vendor List')),
      body: HomeScreen(),
    ),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

// Vendor data
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
