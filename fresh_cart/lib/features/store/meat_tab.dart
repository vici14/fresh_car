import 'package:flutter/material.dart';
import 'package:fresh_car/features/store/base_product_category_screen.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/widgets/ProductCardItem.dart';

import '../../mock_data.dart';

class MeatTab extends StatefulWidget {
  @override
  _MeatTabState createState() => _MeatTabState();
}

class _MeatTabState extends BaseProductCategoryScreen<MeatTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1,
        ),
        itemCount: listProducts.length,
        itemBuilder: (context, index) {
          ProductModel product = listProducts[index];
          return ProductCardItem(
            productModel: product,
            isFromHomeScreen: false,
          );
        });
  }
}
