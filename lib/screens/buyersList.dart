import 'package:assignment_crops_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'buyerCard.dart';

class Buyers {
  final String id;
  final String buyerName;
  final String buyerPhotoUrl;
  final Map<String, dynamic> buyerCropInfo;
  final Map<String, dynamic> buyerLocation;
  final List<dynamic> price;

  Buyers(
      @required this.id,
      @required this.buyerName,
      @required this.buyerPhotoUrl,
      @required this.buyerCropInfo,
      @required this.buyerLocation,
      @required this.price);
}

class BuyersList extends StatefulWidget {
  const BuyersList({Key? key}) : super(key: key);
  static late List<Buyers> listOfBuyers = [];
  static late List<Buyers> newBuyersList = List.from(listOfBuyers);
  @override
  State<BuyersList> createState() => _BuyersListState();
}

class _BuyersListState extends State<BuyersList> {
  Future<List<Buyers>> getBuyerData() async {
    var response = await http.get(
      Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FbuyerList.json?alt=media&token=3dcc96c2-9309-4873-868d-bf0023f6266c'),
    );
    var jsonData = jsonDecode(response.body);
    List<Buyers> buyersData = [];
    for (var u in jsonData) {
      Buyers bData = Buyers(u['id'], u['buyerName'], u['photo'], u['cropInfo'],
          u['location'], u['price']);
      buyersData.add(bData);
    }

    return buyersData;
  }

  @override
  Widget build(BuildContext context) {
    Widget buyerWidget = FutureBuilder(
      future: getBuyerData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null)
          return Container(
            child: Center(
              child: Text(
                'Loading....',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          );
        else {
          BuyersList.listOfBuyers = snapshot.data as List<Buyers>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: BuyersList.newBuyersList
                  .map((e) => BuyerCard(e.id, e.buyerName, e.buyerPhotoUrl,
                      e.buyerCropInfo, e.buyerLocation, e.price))
                  .toList(),
            ),
          );
        }
      },
    );
    return buyerWidget;
  }
}
