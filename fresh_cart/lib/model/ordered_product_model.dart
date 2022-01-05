import 'package:fresh_car/model/product_model.dart';

class OrderedProductModel {
  String id;
  String? imageUrl;
  String? name;
  String? description;
  double? cost;
  String? category;
  int quantity;

  OrderedProductModel(
      {required this.id,
      this.cost,
      this.name,
      this.description,
      this.imageUrl,
      this.category,
      this.quantity = 0});

  factory OrderedProductModel.initial() {
    return OrderedProductModel(
        id: '0',
        quantity: 0,
        category: '',
        imageUrl: '',
        name: '',
        cost: 0,
        description: '');
  }

  factory OrderedProductModel.fromProductModel(
      {required ProductModel product, required int quantity}) {
    return OrderedProductModel(
        id: product.id ?? '0',
        category: product.category,
        imageUrl: product.imageUrl,
        description: product.description,
        cost: product.cost,
        name: product.name,
        quantity: quantity);
  }
}
