import 'package:flutter/cupertino.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

abstract class BaseProductCategoryScreen<T extends StatefulWidget>
    extends State<T> {
  ProductViewModel get productVM =>
      Provider.of<ProductViewModel>(context, listen: false);

  Widget build(BuildContext context);

  void getProductByCategory(String category) {
    switch (category) {
      case "meat":
        productVM.getMeatProducts();
        break;
      case "vegetable":
        productVM.getVegetableProducts();
        break;
      case "house_ware":
        productVM.getHouseWareProducts();
        break;
    }
  }
}
