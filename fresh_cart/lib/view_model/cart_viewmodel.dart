import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/model/ordered_product_model.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/repository/cart_repo_impl.dart';
import 'package:fresh_car/repository/cart_repository.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartViewModel extends BaseViewModel {
  final CartRepository _repository = CartRepositoryImplement();

  static late CartViewModel _instance;

  CartViewModel._internal();

  factory CartViewModel() => _instance;

  static CartViewModel instance() => _instance;

  static void initial() {
    _instance = CartViewModel._internal();
  }

//=======================FIELD VALUE=========================
  CartModel? currentCart;
  bool isGetCart = false;

  void addToCart(
      {required ProductModel productModel,
      required int quantity,
      required String uid}) {
    _repository.addToCart(
        quantity: quantity, uid: uid, productModel: productModel);
  }

  void getCart(String uid) async {
    isGetCart = true;
    notifyListeners();
    currentCart = await _repository.getCart(uid);
    isGetCart = false;
    notifyListeners();
  }

  Future<bool> checkOutCart({
    required String uid,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required List<OrderedProductModel> products,
    required double totalCost,
  }) async {
    currentCart!.totalCost = totalCost;
    currentCart!.orderedItems = products;
    bool isSuccess = await _repository.checkOutCart(
        cartModel: currentCart!,
        uid: uid,
        customerName: customerName,
        customerPhone: customerPhone,
        customerAddress: customerAddress);
    if (isSuccess) {
      getCart(uid);
      return true;
    }
    return false;
  }

  Stream<QuerySnapshot<OrderedProductModel>> getCartItemStream(
      String uid) async* {
    yield* _repository.getCartItemsStream(uid);
  }
}
