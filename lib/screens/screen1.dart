import 'dart:convert';

import 'package:assignment_crops_app/screens/buyersList.dart';
import 'package:assignment_crops_app/screens/searchCard.dart';
import 'package:assignment_crops_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Crops {
  final String cropName, photoUrl, id;
  Crops(@required this.id, @required this.cropName, @required this.photoUrl);
}

class CropsData extends StatefulWidget {
  const CropsData({Key? key}) : super(key: key);
  static const String routeName = '/screen1.0';

  static int selectedCard = -1;
  @override
  State<CropsData> createState() => CropsDataState();
}

class CropsDataState extends State<CropsData> {
  late List<Crops> cd;
  late List<Crops> newDataList = List.from(cd);

  Future<List<Crops>> getCropData() async {
    var response = await http.get(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FcommodityList.json?alt=media&token=9b9e5427-8769-4dec-83c4-52afe727dbf9'));
    var jsonData = jsonDecode(response.body);
    List<Crops> cropsData = [];
    for (var u in jsonData) {
      Crops cropdata = Crops(u['id'], u['commodityName'], u['photo']);

      cropsData.add(cropdata);
    }

    return cropsData;
  }

  TextEditingController _textController = TextEditingController();

  onItemChanged(String value) {
    setState(() {
      newDataList = cd
          .where((crop) =>
              crop.cropName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double usableHeight = MediaQuery.of(context).size.height;
    double usableWidth = MediaQuery.of(context).size.width;

    Widget futureWidget = FutureBuilder(
      future: getCropData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Text(
              'Loading...',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        } else {
          cd = snapshot.data as List<Crops>;

          return GridView.count(
              childAspectRatio: 6 / 2.7,
              crossAxisCount: 3,
              children: newDataList.map((e) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        if (CropsData.selectedCard != int.parse(e.id)) {
                          CropsData.selectedCard = int.parse(e.id);
                          BuyersList.newBuyersList = BuyersList.listOfBuyers
                              .where((crop) => crop.buyerCropInfo['crop']
                                  .toLowerCase()
                                  .contains(e.cropName.toLowerCase()))
                              .toList();
                        } else {
                          CropsData.selectedCard = -1;
                          BuyersList.newBuyersList = BuyersList.listOfBuyers;
                        }
                      });
                    },
                    child: SearchCard(int.parse(e.id), e.cropName, e.photoUrl));
              }).toList());
        }
      },
    );
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: theme.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: usableWidth * 0.02,
              vertical: usableHeight * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: usableHeight * 0.005,
                      horizontal: usableWidth * 0.07),
                  child: FittedBox(
                    child: Text(
                      "What is your crop?",
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: usableWidth * 0.05),
                  width: usableWidth * 0.9,
                  padding: EdgeInsets.symmetric(
                      vertical: usableHeight * 0.005,
                      horizontal: usableWidth * 0.07),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 202, 202, 202),
                            blurRadius: 5,
                            offset: Offset(3, 3))
                      ]),
                  child: TextField(
                    onChanged: onItemChanged,
                    controller: _textController,
                    cursorColor: Colors.black,
                    style: theme.textTheme.bodyText1,
                    textAlignVertical: TextAlignVertical(y: 0),
                    decoration: const InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: const Color.fromARGB(255, 209, 209, 209),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(5),
                      hintText: 'Search Specific Crop',
                      hintStyle: const TextStyle(
                          color: const Color.fromARGB(255, 209, 209, 209),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: usableWidth * 0.02),
                    width: double.infinity,
                    height: usableHeight * 0.2,
                    child: futureWidget),
                SizedBox(
                  height: usableHeight * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: usableHeight * 0.005,
                      horizontal: usableWidth * 0.05),
                  child: FittedBox(
                    child: Text(
                      "Buyer",
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: usableWidth * 0.04,
                    ),

                    // color: Colors.red,
                    height: 140,
                    width: double.infinity,
                    child: BuyersList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
