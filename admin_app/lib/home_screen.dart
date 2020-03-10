import 'package:flutter/material.dart';

import 'add_product_screen.dart';
import 'manage_products_screen.dart';

//Reference: https://flutter.dev/docs/cookbook/design/tabs
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Admin Side App"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Add Product",
              ),
              Tab(
                text: "Manage Products",
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            AddProductScreen(),
            ManageProductScreen(),
          ])),
    );
  }
}
