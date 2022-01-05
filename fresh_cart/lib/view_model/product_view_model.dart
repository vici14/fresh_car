import 'package:fresh_car/mock_data.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

class ProductViewModel extends BaseViewModel {
  ///ProductViewModel main responsibilities is manage all products show on
  ///HomeScreen,StoreScreen,category tabs
  static late ProductViewModel _instance;

  ProductViewModel._internal();

  factory ProductViewModel() {
    return _instance;
  }

  static ProductViewModel instance() => _instance;

  static void initial() {
    _instance = ProductViewModel._internal();
  }

  //=======================FIELD VALUE=========================
  List<ProductModel>? products;

  List<ProductModel> vegetableProducts = [];

  List<ProductModel> meatProducts = [];

  List<ProductModel> houseWareProducts = [];

  //=======================FIELD VALUE=========================

  void getProducts() async {
    products = listProducts;
  }

  void getMeatProducts() async {
    ///filter products with category
  }

  void getVegetableProducts() async {
    ///filter products with category
  }

  void getHouseWareProducts() async {
    ///filter products with category
  }
}
