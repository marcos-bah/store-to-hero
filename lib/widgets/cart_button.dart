import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_to_hero/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
