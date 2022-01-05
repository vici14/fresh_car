import 'package:flutter/material.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:fresh_car/utils/currency_formatter.dart';

class ProductCardItem extends StatefulWidget {
  final ProductModel productModel;
  final bool isFromHomeScreen;

  const ProductCardItem(
      {Key? key, required this.productModel, this.isFromHomeScreen = true})
      : super(key: key);

  @override
  State<ProductCardItem> createState() {
    return _ProductCardItemState();
  }
}

class _ProductCardItemState extends State<ProductCardItem> {
  ProductModel get product => widget.productModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(width: 1, color: Colors.teal),
              image: DecorationImage(
                  image: NetworkImage(
                    product.imageUrl ?? '',
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                height: MediaQuery.of(context).size.width * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          CurrencyFormatter()
                              .toDisplayValue(product.cost, currency: "VNĐ"),
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Text(
            product.name ?? '',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8),
            child: GestureDetector(
              onTap: () async {},
              child: Icon(
                product.isLiked ? Icons.favorite : Icons.favorite_border,
                color: product.isLiked ? Colors.red : null,
              ),
            ),
          ),
        )
      ],
    );
  }
}
