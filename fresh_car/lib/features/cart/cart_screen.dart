import 'package:flutter/material.dart';
import 'package:fresh_car/mock_data.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  double cost = 0;
  double shipCost = 5000;

  @override
  void initState() {
    cost = calculateCost();
    super.initState();
  }

  double calculateCost() {
    double _cost = 0;
    for (var car in listCarsInCart) {
      _cost += car.cost;
    }
    return _cost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: "Giỏ hàng",
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 10,
            bottom: MediaQuery.of(context).size.width * 0.12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nhập tên và địa chỉ người nhận'),
              _buildInputForm(),
              Text("Chi tiết đơn hàng"),
              _buildProductsList(),
              _buildTotal(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(12)),
      height: 52,
      child: Center(
        child: Text(
          "Đặt hàng",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTotal() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tạm tính'),
              Text(cost.toString()),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Khuyến mãi'),
              Text('0'),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phí giao hàng'),
              Text(shipCost.toString()),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng cộng:'),
              Text(
                (cost + shipCost).toString(),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Số lượng'),
                  Text(
                    'Đơn giá',
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        ),
        ...List.generate(listCarsInCart.length, (index) {
          var car = listCarsInCart[index];
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  width: MediaQuery.of(context).size.width * 0.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.teal),
                      image: DecorationImage(
                          image: NetworkImage(
                            car.imageUrl ?? '',
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(car.name ?? '')),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          car.cost.toString(),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    )),
              ],
            ),
          );
        })
      ],
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
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(width: 1, color: Colors.green)),
          child: TextFormField(
            maxLines: null,
            decoration: InputDecoration(
                hintText: "Ghi chú",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 5)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    ));
  }
}
