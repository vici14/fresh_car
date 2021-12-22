import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/repository/product_repo_impl.dart';
import 'package:fresh_car/repository/product_repository.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

class ProductViewModel extends BaseViewModel {
  static late ProductViewModel _instance;

  ProductViewModel._internal();

  factory ProductViewModel() {
    return _instance;
  }

  static ProductViewModel instance() => _instance;

  static void initial() {
    _instance = ProductViewModel._internal();
  }

  ProductRepository _repository = ProductRepositoryImplement();

  //=======================FIELD VALUE=========================

  List<ProductModel>? products;
  bool isLoadingProduct = false;

  //=======================FIELD VALUE=========================

  Future<bool> getProducts() async {
    try {
      isLoadingProduct = true;
      notifyListeners();
      products = await _repository.getProducts();
      isLoadingProduct = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
