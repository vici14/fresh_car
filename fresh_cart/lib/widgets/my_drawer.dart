import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  late ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
            child: Text(
              'Tài khoản',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {},
              child: Text('Lịch sử đơn hàng',
                  style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {},
              child: Text('Sản phẩm yêu thích',
                  style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () async {},
              child: Text('Đăng xuất', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
