import 'package:flutter/material.dart';
import 'package:fresh_car/view_model/user_viewmodel.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';
import 'package:fresh_car/widgets/product_select_dialog.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class FavoriteProductsScreen extends StatefulWidget {
  @override
  State<FavoriteProductsScreen> createState() {
    return _FavoriteProductsScreenState();
  }
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: CommonAppBar(
        title: "My Favorite",
      ),
      body: Consumer<UserViewModel>(
        builder: (BuildContext context, UserViewModel userVM, Widget? child) {
          return (userVM.isLoggedIn == false)
              ? Center(
                  child: Text("Vui lòng "
                      "đăng nhập"),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: userVM.currentUser?.favoriteProducts?.length,
                      itemBuilder: (context, index) {
                        var product =
                            userVM.currentUser?.favoriteProducts![index];
                        return ProductCardItem(productModel: product!);
                      }),
                );
        },
      ),
    );
  }
}
