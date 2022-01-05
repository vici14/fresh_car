import 'package:flutter/cupertino.dart';

abstract class BaseProductCategoryScreen<T extends StatefulWidget>
    extends State<T> {
  Widget build(BuildContext context);

  void getProductByCategory(String category) {
    switch (category) {
      case "meat":
        // productVM.getMeatProducts();
        break;
      case "vegetable":
        // productVM.getVegetableProducts();
        break;
      case "house_ware":
        // productVM.getHouseWareProducts();
        break;
    }
  }
}
