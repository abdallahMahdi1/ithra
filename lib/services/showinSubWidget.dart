import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/url_path.dart';
import 'package:ithra/blocs/subscriber_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ShowinSubWidget extends StatelessWidget {
  const ShowinSubWidget({
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
    String url = urlPath();
    removeFav() async{
      final perf = await SharedPreferences.getInstance();
      final key3 ="publicId";
      final value =perf.getString(key3);
      final response = await http.get(Uri.parse('$url/user/remove/$value/$showId'));
      if(response.statusCode == 200)
      {
      }
      else {
        throw "error";
      }

    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/ShowPage', arguments: {
          "PageName": showname,
          "showId": showId,
          "description": description,
          "showimage": showimage,
        });
      },
      child: Stack(
        children:[
          Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.04),
                      topRight: Radius.circular(MediaQuery.of(context).size.width * 0.04),
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
                      bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.04),
                      bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.04),

                    )),
                child: Center(child: Text(showname!,style: TextStyle(fontSize: 10),)),
                width: MediaQuery.of(context).size.width * 0.325,
                height: MediaQuery.of(context).size.height * 0.05,

              ),

            ],
          ),
        ),
          Container(
            height:MediaQuery.of(context).size.height * 0.035,
            width: MediaQuery.of(context).size.width * 0.075,
            decoration:BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.1))
            ) ,

              child: IconButton(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.003),
                onPressed: ()async {
               await removeFav();
               BlocProvider.of<SubscriberBloc>(context).add(FetchSubscriber());
               }, icon: Icon(Icons.close,color: Colors.red,),),

          )

      ]),
    );
  }
}
