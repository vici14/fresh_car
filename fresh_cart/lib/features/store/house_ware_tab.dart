import 'package:flutter/material.dart';
import 'package:fresh_car/features/store/base_product_category_screen.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';
import 'package:provider/provider.dart';

class HouseWareTab extends StatefulWidget {
  @override
  _HouseWareTabState createState() => _HouseWareTabState();
}

class _HouseWareTabState extends BaseProductCategoryScreen<HouseWareTab> {
  @override
  void initState() {
    super.getProductByCategory('house_ware');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder:
          (BuildContext context, ProductViewModel productVM, Widget? child) {
        if (productVM.isLoadingHouseWare) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productVM.houseWareProducts.isEmpty) {
          return Center(
            child: Text("Danh sách trống"),
          );
        }
        return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1,
            ),
            itemCount: super.userVM.isLoggedIn
                ? productVM.houseWareProductsAfterLoggedIn.length
                : productVM.houseWareProducts.length,
            itemBuilder: (context, index) {
              ProductModel product;

              if (super.userVM.isLoggedIn) {
                product = super.productVM.houseWareProductsAfterLoggedIn[index];
              } else {
                product = super.productVM.houseWareProducts[index];
              }
              return ProductCardItem(productModel: product);
            });
      },
    );
  }
}
