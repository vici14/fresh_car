import 'package:fresh_car/model/ordered_product_model.dart';

class CartModel {
  List<OrderedProductModel>? orderedItems;
  String? note;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? orderCheckoutTime;
  int? dateCreated;
  double totalCost;

  CartModel({
    this.orderCheckoutTime,
    this.dateCreated,
    this.orderedItems,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.note,
    this.totalCost = 0,
  });

  factory CartModel.initial() {
    return CartModel(
      totalCost: 0,
      customerAddress: '',
      orderedItems: [],
      customerName: '',
      customerPhone: '',
      note: '',
      dateCreated: DateTime.now().microsecondsSinceEpoch,
      orderCheckoutTime: 0,
    );
  }
}
