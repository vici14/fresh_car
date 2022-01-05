import 'package:flutter/material.dart';
import 'package:fresh_car/mock_data.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final String appBarBackground = "https://images.unsplash"
      ".com/photo-1616789916437-bbf724d10dae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                appBarBackground,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
            ],
            floating: true,
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
            centerTitle: false,
            title: Text('Car Online'),
          ),
          SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    ProductModel product = listProducts[index];
                    return ProductCardItem(productModel: product);
                  },
                  childCount: listProducts.length,
                ),
              )),
        ],
      ),
    );
  }
}
