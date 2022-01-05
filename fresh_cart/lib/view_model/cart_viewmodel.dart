import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/model/ordered_product_model.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

class CartViewModel extends BaseViewModel {
  ///CartViewModel in this asm2's scope will mainly manage CartModel with
  ///such functions like addToCart, deleteFromCart, save shipping info
  static late CartViewModel _instance;

  CartViewModel._internal();

  factory CartViewModel() => _instance;

  static CartViewModel instance() => _instance;

  static void initial() {
    _instance = CartViewModel._internal();
  }

//=======================FIELD VALUE=========================
  ///cart have list orderedItems in asm2,asm3 list orderedItems is a
  ///collection
  CartModel? currentCart;
  bool isGetCart = false;

  void initialCart() {
    currentCart = CartModel.initial();

    ///create cart
  }

  void addToCart({
    required ProductModel productModel,
    required int quantity,
  }) {
    if (currentCart != null) {
      currentCart!.orderedItems!.add(OrderedProductModel.fromProductModel(
          product: productModel, quantity: quantity));
    }

    /// implement addToCart
    /// same products will increase  quantity
  }

  void deleteFromCart() {
    ///implement delete products from cart
    ///products with quantity = 0 will be remove from cart
  }
}
