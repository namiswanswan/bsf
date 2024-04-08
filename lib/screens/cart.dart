import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Stack(
        children: [
          // Your main content here
          // This could be your list of items in the cart
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Text('Your cart content goes here'),
            ),
          ),

          // Animated container
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: _isVisible ? kToolbarHeight + 20 : -200,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Your Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
