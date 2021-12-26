import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/model/user_model.dart';

abstract class UserRepository {
  Future<bool> updateProfile(
      {required String name,
      required String phone,
      required String address,
      required String uid});

  Future<bool> changePassword();

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<void> likeProduct(
      {required String uid, required ProductModel productModel});

  Future<void> unlikeProduct(
      {required String uid, required ProductModel productModel});

  Future<UserModel?> getCurrentUser();

  Future<UserModel?> logOut();
}
