import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/features/account/account_screen.dart';
import 'package:fresh_car/features/account/favorite_products_screen.dart';
import 'package:fresh_car/features/account/order_history_screen.dart';
import 'package:fresh_car/utils/toast_util.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:fresh_car/view_model/user_viewmodel.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  late UserViewModel userViewModel;
  late ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(color: Colors.black),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomerProfileScreen()));
            },
            child: Text(
              'Tài khoản',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderHistoryScreen()));
              },
              child: Text('Lịch sử đơn hàng',
                  style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FavoriteProductsScreen()));
              },
              child: Text('Sản phẩm yêu thích',
                  style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () async {
                if (userViewModel.currentUser != null) {
                  var _resp = await userViewModel.logOut();
                  if (_resp) {
                    ToastUtils.show(msg: "Đăng xuất thành công!");
                    productViewModel.getProducts();
                    productViewModel.getHouseWareProducts();
                    productViewModel.getMeatProducts();
                    productViewModel.getVegetableProducts();
                  }
                } else {
                  ToastUtils.show(msg: "Bạn chưa đăng nhập");
                }
              },
              child: Text('Đăng xuất', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
