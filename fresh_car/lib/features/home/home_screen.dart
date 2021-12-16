import 'package:flutter/material.dart';
import 'package:fresh_car/features/cart/cart_screen.dart';
import 'package:fresh_car/mock_data.dart';

class HomeScreen extends StatelessWidget {
  final String appBarBackground = "https://images.unsplash"
      ".com/photo-1616789916437-bbf724d10dae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540&q=80";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                appBarBackground,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
                  },
                  icon: Icon(Icons.shopping_cart))
            ],
            floating: true,
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
            centerTitle: false,
            title: Text('Car Online'),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var car = listCars[index];
                  return Stack(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                            car.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: car.isLiked ? Colors.red : null,
                          ),
                        ),
                      )
                    ],
                  );
                },
                childCount: listCars.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
