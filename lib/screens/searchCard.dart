import 'package:flutter/material.dart';
import 'screen1.dart';

class SearchCard extends StatefulWidget {
  final String name;
  final int id;
  final String url;

  SearchCard(@required this.id, @required this.name, @required this.url);

  @override
  State<SearchCard> createState() => SearchCardState();
}

class SearchCardState extends State<SearchCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: CropsData.selectedCard == widget.id
            ? Border.all(width: 1, color: Colors.black)
            : null,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 202, 202, 202),
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
      child: Row(children: [
        Image.network(
          widget.url,
          fit: BoxFit.contain,
          height: 25,
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ]),
    );
  }
}
