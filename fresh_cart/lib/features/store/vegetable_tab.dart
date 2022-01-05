import 'package:flutter/material.dart';
import 'package:fresh_car/features/store/base_product_category_screen.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';
import 'package:fresh_car/widgets/product_select_dialog.dart';
import 'package:provider/provider.dart';
import '../../mock_data.dart';

class VegetableTab extends StatefulWidget {
  @override
  _VegetableTabState createState() => _VegetableTabState();
}

class _VegetableTabState extends BaseProductCategoryScreen<VegetableTab> {
  @override
  void initState() {
    super.getProductByCategory('vegetable');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder:
          (BuildContext context, ProductViewModel productVM, Widget? child) {
        if (productVM.vegetableProducts.isEmpty) {
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
            itemCount: productVM.vegetableProducts.length,
            itemBuilder: (context, index) {
              ProductModel product;
              product = super.productVM.vegetableProducts[index];

              return ProductCardItem(
                productModel: product,
                isFromHomeScreen: false,
              );
            });
      },
    );
  }
}
