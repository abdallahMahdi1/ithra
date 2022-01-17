import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/pages/home_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ithra/api_fetch/Subscriber_fetch.dart';
import 'package:ithra/blocs/subscriber_bloc.dart';
import 'package:ithra/services/audioBar.dart';
import 'package:ithra/blocs/audio_player_bloc.dart';
import 'package:ithra/services/showinSubWidget.dart';



class Subscribe extends StatefulWidget {
  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    BlocProvider.of<SubscriberBloc>(context).add(FetchSubscriber());
    _refreshController.refreshCompleted();

  }
  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;
    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        children:[ SmartRefresher(
          enablePullDown: true,


          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
            child: ListView(

              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: BlocBuilder<SubscriberBloc, SubscriberState>(
                    builder: (BuildContext context, state) {
                      if (state is AppIsClosed1) {
                        return Container();
                      }
                      if(state is SubscriberIsLoading)
                      {
                        return  Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.7,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              height: MediaQuery.of(context).size.height*0.04,
                              child: CircularProgressIndicator(color: Colors.black,),
                            ),
                          ),);
                      }
                      if (state is SubscriberSuccessful){
                        return  FutureBuilder(
                            future: fetchSubscriber(),
                            builder: (context, snapshot){

                                if(state.result.users![0].subscribers!.isEmpty)
                                  {
                                    return Stack(
                                      children:[
                                        Container(
                                          height:MediaQuery.of(context).size.height*0.7 ,
                                          width: MediaQuery.of(context).size.width ,
                                          child: Image.asset("images/emptyFav.png",fit: BoxFit.fill,)),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height:MediaQuery.of(context).size.height*0.65 ,
                                          width: MediaQuery.of(context).size.width ,

                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xff7c94b6),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft:Radius.circular(15) ,
                                                  bottomLeft: Radius.circular(30),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                            ),

                                            height:MediaQuery.of(context).size.height*0.07 ,
                                            width: MediaQuery.of(context).size.width*0.3 ,
                                            alignment: Alignment.bottomCenter,
                                            child: Center(
                                              child: TextButton(
                                                onPressed: (){
                                                  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                                                    return new HomePage();
                                                  }));
                                                },
                                                child: AutoSizeText("اكتشف البرامج",maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 14),overflow: TextOverflow.clip,)

                                              ),
                                            ),

                                          ),
                                        )

                                  ]);
                                  }
                                else {
                                  return GridView.builder(
                                      physics: ScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5,
                                          mainAxisExtent: MediaQuery.of(context).size.height*0.25
                                      ),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding:EdgeInsets.all(16.0) ,
                                      itemCount: state.result.users![0].subscribers!.length,
                                      itemBuilder: (context, index) {
                                        if (state.result.users![0].subscribers!.length == 0) {
                                          print(state.result.users![0].subscribers!.length);
                                          return Container(child: Text("الرجاء اضافة المزيد"),);
                                        }
                                        else {
                                          return Container(
                                            child: Center(
                                              child: ShowinSubWidget(
                                                showimage: state.result.users![0].subscribers![index].showimg,
                                                showname: state.result.users![0].subscribers![index].showname,
                                                showId: state.result.users![0].subscribers![index].id,
                                                description: state.result.users![0].subscribers![index].description,
                                              ),
                                            ),

                                          );
                                        }
                                      });
                                }
                              }




                        );
                      }
                      if(state is SubscriberFailed){
                        return  Container(
                          height: MediaQuery.of(context).size.height*0.8 ,

                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,

                              child: Text(
                                "اسحب لاسفل لاعادة التحميل",style: TextStyle(color: Colors.black),),

                            ),
                          ),
                        );
                      }

                      return  Text("");
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.1)
              ],
            ),),
            BB(audioBloc:_audioBloc)

          ],
        ),
      ),

    );
  }
}
