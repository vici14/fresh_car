import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/model/user_model.dart';
import 'package:fresh_car/repository/user_repo_impl.dart';
import 'package:fresh_car/repository/user_repository.dart';
import 'package:fresh_car/view_model/base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  final UserRepository _repository = UserRepositoryImpl();
  static late UserViewModel _instance;

  UserViewModel._internal();

  factory UserViewModel() {
    return _instance;
  }

  static UserViewModel instance() => _instance;

  static void initial() {
    _instance = UserViewModel._internal();
  }

  //=======================FIELD VALUE=========================

  UserModel? currentUser;
  bool isLoggedIn = false;

  //=======================FIELD VALUE=========================

  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _repository.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> likeProduct(ProductModel productModel) async {
    await _repository.likeProduct(
        uid: currentUser?.uid ?? '', productModel: productModel);
    refreshCurrentUser();
  }

  Future<void> unlikeProduct(ProductModel productModel) async {
    await _repository.unlikeProduct(
        uid: currentUser?.uid ?? '', productModel: productModel);
    refreshCurrentUser();
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      isLoggedIn = false;
      var _resp = await _repository.signInWithEmailAndPassword(
          email: email, password: password);
      if (_resp) {
        currentUser = await _repository.getCurrentUser();
        isLoggedIn = true;
      }
      notifyListeners();
      return _resp;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  void refreshCurrentUser() async {
    currentUser = await _repository.getCurrentUser();
    notifyListeners();
  }

  void updateProfile(
      {required String name,
      required String phone,
      required String address}) async {
    var _resp = await _repository.updateProfile(
        name: name,
        phone: phone,
        address: address,
        uid: currentUser?.uid ?? '');
    if (_resp) {
      refreshCurrentUser();
    }
  }
}
