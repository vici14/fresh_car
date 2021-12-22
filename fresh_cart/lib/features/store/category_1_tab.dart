import 'package:flutter/material.dart';
import 'package:fresh_car/widgets/product_select_dialog.dart';

import '../../mock_data.dart';

class Category1Tab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1,
        ),
        itemCount: listCars.length,
        itemBuilder: (context, index) {
          var car = listCars[index];
          return GestureDetector(
            onTap: () async {
              await showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.5),
                transitionBuilder: (context, a1, a2, widget) {
                  return Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: ProductSelectDialog(
                        productModel: car,
                      ),
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return ProductSelectDialog(
                    productModel: car,
                  );
                },
              );
            },
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1, color: Colors.teal),
                      image: DecorationImage(
                          image: NetworkImage(
                            car.imageUrl ?? '',
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
                                  car.cost.toString(),
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
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Text(
                    car.name ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8),
                    child: Icon(
                      car.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: car.isLiked ? Colors.red : null,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
