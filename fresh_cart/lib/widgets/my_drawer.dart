import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/features/account/account_screen.dart';
import 'package:fresh_car/features/account/favorite_products_screen.dart';
import 'package:fresh_car/features/account/order_history_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Text('Đăng xuất', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
