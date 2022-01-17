import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/api_fetch/Subscriber_fetch.dart';
import 'package:ithra/api_fetch/episodes_fetch.dart';
import 'package:ithra/api_fetch/url_path.dart';
import 'package:ithra/blocs/subscriber_bloc.dart';
import 'package:ithra/modules/Subscriber_module.dart';
import 'package:ithra/modules/episodes_module.dart';
import 'package:ithra/services/audioBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/audio_player_bloc.dart';


class ShowPage extends StatefulWidget {
  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  Map? data = {};
  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
    String url = urlPath();
    String showName = data!["PageName"];
    String showId = data!["showId"];
    String description = data!["description"];
    String showImage = data!["showimage"];
    bool subs = false;
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;
    addFav() async {
      final perf = await SharedPreferences.getInstance();
      final key3 ="publicId";
      final value =perf.getString(key3);
      Subscriber sub = await fetchSubscriber();
      int index = sub.users![0].subscribers!.length ;

      for (int i = 0; i < index ;i++){
        if(sub.users![0].subscribers![i].id == showId){
          setState(() {
            subs = true;

          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('موجود في المفضلة مسبقا '),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),

          ));
          break;
        }
        else {
        }
      }
      if (subs == false){
        final response = await http.get(Uri.parse('$url/user/new/$value/$showId'));
        if(response.statusCode == 200)
        {
          BlocProvider.of<SubscriberBloc>(context).add(FetchSubscriber());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('تم الاضافه الى المفضله'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ));
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('الرجاء التاكد من الاتاصل بالانترنت'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),

          ));
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('الرجاء التاكد من الاتاصل بالانترنت'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),

        ));
      }


    }
    return Directionality(textDirection: TextDirection.rtl, child:SafeArea(
      child: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.black,
          ),
        body:Stack(
          children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.bottomRight,

                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.4,
                    child: ClipRRect(
                      child: Image.network(
                        showImage,
                        fit: BoxFit.fill,
                      ),

                    )),
                  Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        height:MediaQuery.of(context).size.height*0.05 ,
                        width:MediaQuery.of(context).size.width*0.4 ,

                        child: FittedBox(
                          fit: BoxFit.fill,

                          child:TextButton.icon(
                              onPressed: () {
                                addFav();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('جار الاضافة الى المفضلة'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 3),
                                ));



                              },
                              icon: Icon(Icons.favorite,color: Colors.red,),
                              label: Text("اضف الي المفضلة",style: TextStyle(color: Colors.black),)
                          )
                        ),
                      )

                  )],),

              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(   borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black,width: 1)
                ),

                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),

                      width: MediaQuery.of(context).size.width,
                      child: Directionality(
                        textDirection:TextDirection.rtl,
                        child: Text(showName,
                            style: TextStyle(
                              fontSize:24,
                              letterSpacing: 2,
                            )),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Directionality(
                          textDirection:TextDirection.rtl,
                          child: Text(description,textAlign: TextAlign.justify,style: TextStyle(fontFamily:"Tajwal" ),)),
                    ),
                  ],
                ),
              ),

              Divider(height: 20,),

              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child:Row(
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 10),
                      Text("الحلقات",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                          )),
                    ],
                  )
                ),
              ),


              FutureBuilder<EpisodeList>(
                future: fetchEpisode(showId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.episodes!.length,
                        itemBuilder: (context, index) {
                          return EpisodeCard(
                              episodeName :snapshot.data!.episodes![index].episodeName,
                              showname: showName,
                              showImg: showImage,
                              episodeUrl :snapshot.data!.episodes![index].episodeUrl,
                              episodeDescr:
                              snapshot.data!.episodes![index].episodeDescr,
                              episodeNum:
                              snapshot.data!.episodes![index].episodeNum);
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              fetchEpisode(showId);
                            });
                          },
                          child: Text("اعد المحاول"),
                        ));
                  }

                  return Center(child: CircularProgressIndicator(color :Colors.black));
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.1)
            ],
          ),
            BB(audioBloc: _audioBloc,)



        ],)



      ),
    ));
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episodeNum,
    required this.episodeDescr, this.audioPlayer, this.episodeUrl, this.showImg, this.showname,this.episodeName
  }) : super(key: key);
  final audioPlayer;
  final String? episodeNum;
  final String? episodeDescr;
  final String? episodeUrl;
  final String? showImg;
  final String? showname;
  final String? episodeName;

  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;

    return InkWell(
      onTap: (){
        _audioBloc.add(FetchAudio(url: episodeUrl,name: episodeName ,img:showImg,showName:showname));
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
        child: ListTile(
          title: Text(episodeName!),
          leading: Text(episodeNum!),
          subtitle: Text(episodeDescr!),
        ),
      )
    );
  }
}
