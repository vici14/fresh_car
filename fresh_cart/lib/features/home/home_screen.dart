import 'package:flutter/material.dart';
import 'package:fresh_car/features/cart/cart_screen.dart';
import 'package:fresh_car/mock_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:fresh_car/view_model/user_viewmodel.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductViewModel productViewModel;
  late UserViewModel userViewModel;

  @override
  void initState() {
    productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    productViewModel.getProducts();

    if (userViewModel.isLoggedIn) {
      productViewModel.getProductsAfterUserLoggedIn(
          userViewModel.currentUser!.favoriteProducts!);
    }
    super.didChangeDependencies();
  }

  final String appBarBackground = "https://images.unsplash"
      ".com/photo-1616789916437-bbf724d10dae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80";

  final _productsStream = FirebaseFirestore.instance
      .collection('products')
      .withConverter<ProductModel>(
          fromFirestore: (snapshots, _) =>
              ProductModel.fromQuerySnapshot(snapshots.data()!),
          toFirestore: (carModel, _) => carModel.toJson());

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder:
          (BuildContext context, ProductViewModel productVM, Widget? child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: productVM.isLoadingProduct
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
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
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                            },
                            icon: Icon(Icons.shopping_cart))
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              ProductModel product;
                              if (userViewModel.isLoggedIn) {
                                product = productViewModel
                                    .productsAfterLoggedIn![index];
                              } else {
                                product = productVM.products![index];
                              }

                              return ProductCardItem(productModel: product);
                            },
                            childCount: userViewModel.isLoggedIn
                                ? productViewModel.productsAfterLoggedIn?.length
                                : productViewModel.products?.length,
                          ),
                        )),
                  ],
                ),
        );
      },
    );
  }
}
