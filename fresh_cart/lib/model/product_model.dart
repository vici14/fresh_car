class ProductModel {
  String? imageUrl;
  String? name;
  String? description;
  bool isLiked;
  double cost;
  String? id;
  String? category;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.isLiked,
    required this.cost,
    required this.id,
    required this.category,
  });
}
