import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowWidget extends StatelessWidget {
  const ShowWidget({
    Key? key,
    required this.showimage,
    required this.showname,
    required this.showId,
    required this.description,
  }) : super(key: key);
  final String? description;
  final String? showId;
  final String? showimage;
  final String? showname;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/ShowPage', arguments: {
          "PageName": showname,
          "showId": showId,
          "description": description,
          "showimage": showimage,
        });
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            width: MediaQuery.of(context).size.width * 0.325,
            height: MediaQuery.of(context).size.height * 0.175,
            child: Image.network(showimage!,
                fit:BoxFit.fill ,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("images/Default.png",fit: BoxFit.fill,);
                }
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),

                )),
            child: Center(child: Text(showname!,style: TextStyle(fontSize: 10),)),
            width: MediaQuery.of(context).size.width * 0.325,
            height: MediaQuery.of(context).size.height * 0.05,

          ),

        ],
      ),
    );
  }
}
