import 'package:fresh_car/model/ordered_product_model.dart';

class CartModel {
  List<OrderedProductModel>? orderedItems;
  String? note;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  int? orderCheckoutTime;
  int? dateCreated;

  CartModel({
    this.orderCheckoutTime,
    this.dateCreated,
    this.orderedItems,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.note,
  });

  // double get totalPrice {
  //   double _totalCost = 0;
  //   orderedItems?.forEach((element) {
  //     _totalCost += element.quantity * double.parse(element.cost.toString());
  //   });
  //   return _totalCost;
  // }

  factory CartModel.initial() {
    return CartModel(
        orderedItems: [],
        customerName: '',
        customerPhone: '',
        note: '',
        dateCreated: DateTime.now().microsecondsSinceEpoch,
        orderCheckoutTime: 0);
  }

  factory CartModel.fromQuerySnapshot(Map<String, dynamic> snapshot) {
    return CartModel(
      customerName: snapshot['customerName'],
      customerPhone: snapshot['customerPhone'],
      customerAddress: snapshot['customerAddress'],
      note: snapshot['note'],
      orderedItems: (snapshot['orderedItems'].length > 0 &&
              snapshot['orderedItems'] != null)
          ? List<OrderedProductModel>.generate(
              snapshot['orderedItems'].length,
              (index) => OrderedProductModel.fromQuerySnapshot(
                  snapshot['orderedItems'][index])).toList()
          : [],
    );
  }

  CartModel withShippingInformation({
    required String customerName,
    required String customerPhone,
    required String customerAddress,
  }) {
    return CartModel(
      dateCreated: dateCreated,
      customerPhone: customerPhone,
      customerName: customerName,
      orderedItems: this.orderedItems,
      note: this.note,
      orderCheckoutTime: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderedItems': List.generate(
          orderedItems!.length, (index) => orderedItems![index].toJson()),
      'note': note,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
    };
  }
}
