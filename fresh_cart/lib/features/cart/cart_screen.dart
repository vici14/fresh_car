import 'package:flutter/material.dart';
import 'package:fresh_car/mock_data.dart';
import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/model/ordered_product_model.dart';
import 'package:fresh_car/utils/currency_formatter.dart';
import 'package:fresh_car/utils/string_util.dart';
import 'package:fresh_car/utils/validation_util.dart';
import 'package:fresh_car/view_model/cart_viewmodel.dart';
import 'package:fresh_car/widgets/my_app_bar.dart';
import 'package:fresh_car/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  double shipCost = 0;
  List<OrderedProductModel>? list;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late CartViewModel _cartViewModel;

  @override
  void initState() {
    _cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
          title: "Giỏ hàng",
        ),
        body: Consumer<CartViewModel>(
          builder: (BuildContext context, CartViewModel cartVM, Widget? child) {
            return Container(
              padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 10,
                  bottom: MediaQuery.of(context).size.width * 0.12),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Text('Nhập tên và địa chỉ người nhận'),
                    _buildInputForm(),
                    Text("Chi tiết đơn hàng"),
                    _buildProductsList(cartVM.currentCart!.orderedItems),
                    _buildTotal(
                        totalCost: StringUtil.calculateTotalCost(
                            cartVM.currentCart!.orderedItems!)),
                    _buildSubmitButton(onTap: () async {}),
                  ])),
            );
          },
        ));
  }

  Widget _buildTotal({required double totalCost}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
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
              Text(CurrencyFormatter()
                  .toDisplayValue(totalCost, currency: "VNĐ")),
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
              Text(CurrencyFormatter()
                  .toDisplayValue(shipCost, currency: "VNĐ")),
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
                CurrencyFormatter()
                    .toDisplayValue((totalCost + shipCost), currency: "VNĐ"),
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

  Widget _buildSubmitButton({required Function()? onTap}) {
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
            "Đặt hàng",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
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
            // _buildCustomButton(
            //     onTap: () {
            //       if (isValidate()) {
            //         userVM.updateProfile(
            //             name: _nameController.text,
            //             phone: _phoneController.text,
            //             address: _addressController.text);
            //       }
            //     },
            //     title: "Cập nhật thông tin"),
          ],
        ));
  }

  Widget _buildProductsList(List<OrderedProductModel>? items) {
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
        ...List.generate(items!.length, (index) {
          var item = items[index];
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
                            item.imageUrl ?? '',
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(item.name ?? '')),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.quantity.toString(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          CurrencyFormatter()
                              .toDisplayValue(item.cost, currency: "VNĐ"),
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
}
