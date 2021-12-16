import 'package:flutter/material.dart';
import 'package:fresh_car/model/car_model.dart';

class CarDialog extends StatefulWidget {
  final CarModel carModel;

  const CarDialog({Key? key, required this.carModel}) : super(key: key);

  @override
  State<CarDialog> createState() {
    return _CarDialogState();
  }
}

class _CarDialogState extends State<CarDialog> {
  CarModel get _car => widget.carModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(width: 1, color: Colors.teal),
                          image: DecorationImage(
                              image: NetworkImage(
                                _car.imageUrl ?? '',
                              ),
                              fit: BoxFit.fill)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_car.name ?? ''),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              _car.cost.toString(),
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Giới thiệu'),
              ),
              Container(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Scrollbar(
                  child: ListView(
                    children: [Text(_car.description ?? '')],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                      Text('0'),
                      IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      width: 100,
                      child: Center(
                          child: Text(
                        _car.cost.toString(),
                        style: TextStyle(color: Colors.white),
                      )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
