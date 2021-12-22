import 'package:fresh_car/model/product_model.dart';

class OrderedProductModel {
  String? imageUrl;
  String? name;
  String? description;
  double? cost;
  String? category;
  int quantity;

  OrderedProductModel(
      {this.cost,
      this.name,
      this.description,
      this.imageUrl,
      this.category,
      this.quantity = 0});

  factory OrderedProductModel.fromQuerySnapshot(Map<String, dynamic> snapshot) {
    return OrderedProductModel(
      cost: snapshot['cost'] != null
          ? double.parse(snapshot['cost'].toString())
          : 0,
      description: snapshot['description'] != null
          ? snapshot['description'] as String
          : '',
      imageUrl:
          snapshot['imageUrl'] != null ? snapshot['imageUrl'] as String : '',
      name: snapshot['name'] != null ? snapshot['name'] as String : '',
      quantity: snapshot['quantity'] != null ? snapshot['quantity'] as int : 0,
    );
  }

  factory OrderedProductModel.fromProductModel(
      {required ProductModel product, required int quantity}) {
    return OrderedProductModel(
        category: product.category,
        imageUrl: product.imageUrl,
        description: product.description,
        cost: product.cost,
        name: product.name,
        quantity: quantity);
  }

  Map<String, Object?> toJson() {
    return {
      'cost': cost,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'name': name,
    };
  }
}
