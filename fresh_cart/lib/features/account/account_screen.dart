import 'package:flutter/material.dart';
import 'package:fresh_car/mock_data.dart';
import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/model/ordered_product_model.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/model/user_model.dart';
import 'package:fresh_car/utils/validation_util.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:fresh_car/view_model/user_viewmodel.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class CustomerProfileScreen extends StatefulWidget {
  @override
  State<CustomerProfileScreen> createState() {
    return _CustomerProfileScreenState();
  }
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  ProductViewModel? _productViewModel;

  @override
  Widget build(BuildContext context) {
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    String email = 'cuongchau16@gmail.com';
    String password = '123456789';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MyDrawer(),
        appBar: CommonAppBar(
          title: "Tài khoản",
        ),
        body: Consumer<UserViewModel>(
          builder: (BuildContext context, UserViewModel userVM, Widget? child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    userVM.isLoggedIn ? _buildIntro(userVM) : SizedBox.shrink(),
                    userVM.isLoggedIn ? _buildInputForm() : SizedBox.shrink(),
                    _buildRegisterButton(onTap: () {
                      userVM.signUpWithEmailAndPassword(
                          email: email, password: password);
                    }),
                    _buildSignInButton(
                      onTap: () async {
                        var _resp = await userVM.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (_resp) {
                          _productViewModel?.getProductsAfterUserLoggedIn(
                              userVM.currentUser!.favoriteProducts!);
                          _productViewModel
                              ?.updateCategoryProductsAfterUserLoggedIn(
                                  userVM.currentUser!.favoriteProducts!);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIntro(UserViewModel userVM) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tài khoản :"),
            Text(userVM.currentUser?.email ?? '')
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
          child: Text(
            "Đổi password",
            style: TextStyle(
                color: Colors.red, decoration: TextDecoration.underline),
          ),
        ),
        Text(
          'Lưu thông tin của bạn để tự động điền trong thông tin '
          'đặt hàng',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildInputForm() {
    return Consumer<UserViewModel>(
      builder: (BuildContext context, UserViewModel userVM, Widget? child) {
        if (userVM.isLoggedIn && userVM.currentUser != null) {
          _phoneController.text = userVM.currentUser?.phone ?? '';
          _nameController.text = userVM.currentUser?.name ?? '';
          _addressController.text = userVM.currentUser?.address ?? '';
        }
        return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(width: 1, color: Colors.green)),
                  child: TextFormField(
                    validator: (val) => ValidationUtil.isNotNullOrEmpty(val),
                    controller: _nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Họ và tên ",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(width: 1, color: Colors.green)),
                  child: TextFormField(
                    validator: (val) => ValidationUtil.isNotNullOrEmpty(val),
                    controller: _phoneController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Số điện thoại ",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(width: 1, color: Colors.green)),
                  child: TextFormField(
                    controller: _addressController,
                    validator: (val) => ValidationUtil.isNotNullOrEmpty(val),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Địa chỉ người nhận ",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                _buildCustomButton(
                    onTap: () {
                      if (isValidate()) {
                        userVM.updateProfile(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            address: _addressController.text);
                      }
                    },
                    title: "Cập nhật thông tin"),
              ],
            ));
      },
    );
  }

  bool isValidate() {
    return _formKey.currentState!.validate();
  }

  Widget _buildRegisterButton({required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        height: 52,
        child: Center(
          child: Text(
            "Đăng kí ",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton({required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        height: 52,
        child: Center(
          child: Text(
            "Đăng Nhập",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(
      {required String title, required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        height: 52,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
