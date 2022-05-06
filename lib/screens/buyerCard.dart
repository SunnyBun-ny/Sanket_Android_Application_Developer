import 'package:assignment_crops_app/screens/screen2.dart';
import 'package:flutter/material.dart';

class BuyerCard extends StatelessWidget {
  final String id;
  final String buyerName;
  final String buyerPhotoUrl;
  final Map<String, dynamic> buyerCropInfo;
  final Map<String, dynamic> buyerLocation;
  final List<dynamic> price;
  BuyerCard(
      @required this.id,
      @required this.buyerName,
      @required this.buyerPhotoUrl,
      @required this.buyerCropInfo,
      @required this.buyerLocation,
      @required this.price);
  @override
  Widget build(BuildContext context) {
    Widget priceContainer(dynamic price) {
      return Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(1),
        color: Color.fromARGB(255, 243, 243, 243),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.amber,
              child: Text(
                price['date'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    '\u{20B9}${double.parse(price['price'])}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                  Text(price['sku'],
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black45,
                      ))
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 125,
      width: 335,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 202, 202, 202),
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(left: 0, top: 5, bottom: 5, right: 0),
      child: Row(
        children: [
          Container(
            // color: Colors.red,
            child: Image.network(
              buyerPhotoUrl,
              height: 150,
              width: 100,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.yellow,
                  child: Row(
                    children: [
                      Image.network(
                        buyerCropInfo['photo'],
                        height: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        child: Text(buyerCropInfo['crop']),
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.blue,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: FittedBox(
                    child: Text(
                      buyerName,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      ...price.map((e) => priceContainer(e)).toList(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
