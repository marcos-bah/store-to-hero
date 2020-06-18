import 'package:flutter/material.dart';
import 'package:loja_to_hero/tabs/home_tab.dart';
import 'package:loja_to_hero/tabs/products_tab.dart';
import 'package:loja_to_hero/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
