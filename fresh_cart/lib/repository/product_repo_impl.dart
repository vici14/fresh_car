import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/repository/product_repository.dart';
import 'package:fresh_car/service/service_manager.dart';

class ProductRepositoryImplement extends ProductRepository {
  ServiceManager serviceManager = ServiceManager();
  @override
  Future<bool> addToFavorite(String productId) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    return await serviceManager.getProducts();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    return await serviceManager.getProductsByCategory(categoryId);
  }
}
