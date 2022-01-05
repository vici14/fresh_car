import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

class ProductDetailViewModel extends BaseViewModel {
  ///when user click on cardProductItem we will create a
  ///ProductDetailViewModel to manage UI's data such as quantity, product
  final ProductModel productModel;

  ProductDetailViewModel(this.productModel);

  int quantity = 1;

  increaseQuantity() {
    ///implement increaseQuantity
  }

  decreaseQuantity() {
    ///implement decreaseQuantity
  }

  double get totalCost {
    return quantity * productModel.cost;
  }
}
