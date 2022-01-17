import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.categoryName,
    required this.iconCode,
  }) : super(key: key);
  final String? categoryName;
  final String? iconCode;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon( IconData(int.parse("$iconCode"), fontFamily: 'MaterialIcons'))),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            alignment: Alignment.centerLeft,
            child: Text(categoryName!, style: TextStyle(fontSize: 18)),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }
}
