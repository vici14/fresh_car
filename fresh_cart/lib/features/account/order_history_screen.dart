import 'package:flutter/material.dart';
import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/utils/currency_formatter.dart';
import 'package:fresh_car/view_model/user_viewmodel.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: CommonAppBar(
        title: "Lịch sử đơn hàng",
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
        child: Consumer<UserViewModel>(
          builder: (BuildContext context, UserViewModel userVM, Widget? child) {
            if (!userVM.isLoggedIn) {
              return Center(
                child: Text("Vui lòng đăng nhập"),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(userVM.currentUser!.orderHistory!.length,
                      (index) {
                    var cart = userVM.currentUser!.orderHistory![index];
                    return _buildOrderHistoryItem(cart);
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderHistoryItem(CartModel cartModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: Colors.green, width: 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tên người nhận:'),
              Text(cartModel.customerName ?? '')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số điện thoai:'),
              Text(cartModel.customerPhone ?? '')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Địa chỉ:'), Text(cartModel.customerAddress ?? '')],
          ),
          Divider(
            color: Colors.black,
            endIndent: 5,
            indent: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng đơn hàng'),
              Text(CurrencyFormatter()
                  .toDisplayValue(cartModel.totalCost, currency: 'VNĐ'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ngày thanh toán:'),
              Text(DateFormat("yMd").format(DateTime.fromMicrosecondsSinceEpoch(
                  cartModel.orderCheckoutTime ?? 0))),
            ],
          ),
        ],
      ),
    );
  }
}
