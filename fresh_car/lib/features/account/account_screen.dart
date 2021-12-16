import 'package:flutter/material.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';

class CustomerProfileScreen extends StatefulWidget {
  @override
  State<CustomerProfileScreen> createState() {
    return _CustomerProfileScreenState();
  }
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: CommonAppBar(
        title: "Tài khoản",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Tài khoản :"), Text('abc@gmail.com')],
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
            _buildInputForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return Form(
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
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                hintText: "Địa chỉ người nhận ",
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    ));
  }
}
