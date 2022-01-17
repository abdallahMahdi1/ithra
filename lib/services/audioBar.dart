import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


import '../blocs/audio_player_bloc.dart';

class BB extends StatelessWidget {
  const BB({
    Key? key,
    required AudioBloc audioBloc,
  }) : audioBloc = audioBloc, super(key: key);

  final AudioBloc audioBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: audioBloc,
      builder: (context,dynamic state){
        if (state is AudioIsNotSearched){
          return Container(
            height: 0,
            width: 0,
          );
        }
        else if(state is AudioIsLoading){
          return Container(
            width:MediaQuery.of(context).size.width ,
            child: SlidingUpPanel(

              maxHeight : MediaQuery.of(context).size.height * 0.4,
              minHeight:  MediaQuery.of(context).size.height * 0.1,
              backdropEnabled:true,

              header: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width:MediaQuery.of(context).size.width ,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                ),
                  ),
              panel: Column(

              )



            ),
          );
        }
        else if(state is AudioIsPlaying){
          return Container(
            width:MediaQuery.of(context).size.width ,
            child: SlidingUpPanel(

              maxHeight : MediaQuery.of(context).size.height * 0.4,
              minHeight:  MediaQuery.of(context).size.height * 0.1,
              backdropEnabled:true,

              header: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                  width:MediaQuery.of(context).size.width ,
                 child:Row(
                   children: [
                     SizedBox(width:MediaQuery.of(context).size.width *0.01 ),
                     Container(

                       height:MediaQuery.of(context).size.height * 0.09 ,
                       width:MediaQuery.of(context).size.width * 0.18 ,
                       child: Image.network(state.image,
                           fit:BoxFit.fill ,
                           errorBuilder: (context, error, stackTrace) {
                             return Image.asset("images/Default.png",fit: BoxFit.fill,);
                           }
                       ),

                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(5),),border: Border.all()),
                       //play-circle

                     ),
                     SizedBox(width:MediaQuery.of(context).size.width*0.04),
                     Container(
                       width:MediaQuery.of(context).size.width * 0.6,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,

                         children: [
                         Container(
                           child: Text(state.name,style:TextStyle(fontSize: 16),overflow: TextOverflow.clip,),
                         ),
                         Container(
                           child: Text(state.showName,style:TextStyle(color:Colors.grey),),
                         )
                       ],),
                     ),
                     Container(
                       width: MediaQuery.of(context).size.width*0.12,
                       child: StreamBuilder<bool>(
                           stream: state.player!.isPlaying ,
                           builder: (context, asyncSnapshot) {
                             final bool isPlaying = asyncSnapshot.data ?? true;
                             return IconButton(icon :isPlaying ? Icon(Icons.pause_circle_outline,size: 30,) : Icon(Icons.play_circle_outline,size: 30),
                                 onPressed: (){
                                   isPlaying ? state.player!.pause(): state.player!.play();
                                 });
                           }),
                     ),


                   ],
                 )),
              panel: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Divider(height: 1,color: Colors.black,),


                  StreamBuilder<bool>(
                      stream: state.player!.isBuffering ,
                      builder: (context, asyncSnapshot) {
                        final bool isBuffering = asyncSnapshot.data ?? true;
                        return isBuffering? Text("جاري التحميل") :Text("");
                      }),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: PlayerBuilder.currentPosition(
                        player: state.player!,
                        builder: (context, duration) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Slider.adaptive(
                                  max: state.max!.inSeconds.toDouble(),
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                  min: 0.0,
                                  value: duration.inSeconds.toDouble(),
                                  onChanged: (double value){
                                    state.player!.seek(new Duration(seconds: value.toInt()));
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(duration.toString().substring(2,7)),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.7 ),
                                  Text(state.max.toString().substring(2,7)),
                                ],
                              )

                            ],

                          );
                        }
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.forward_10,size: 45,),
                          onPressed: () {
                            state.player!.seekBy(Duration(seconds: -10));
                          },
                        ),
                        SizedBox( width:MediaQuery.of(context).size.width*0.04),
                        Container(

                          child: StreamBuilder<bool>(
                              stream: state.player!.isPlaying ,
                              builder: (context, asyncSnapshot) {
                                final bool isPlaying = asyncSnapshot.data ?? true;
                                return IconButton(icon :isPlaying ? Icon(Icons.pause_circle_outline,size: 50,) : Icon(Icons.play_circle_outline,size: 50),
                                    onPressed: (){
                                      isPlaying ? state.player!.pause(): state.player!.play();
                                    });
                              }),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                        IconButton(

                          icon: Icon((Icons.replay_30),size: 45,),
                          onPressed: () {
                            state.player!.seekBy(Duration(seconds: 10));
                          },
                        ),
                      ],),
                  ),

                ],

              ),



            ),
          );
        }
        else  {
        return  Container(
          width:MediaQuery.of(context).size.width ,
          child: SlidingUpPanel(

              maxHeight : MediaQuery.of(context).size.height * 0.4,
              minHeight:  MediaQuery.of(context).size.height * 0.1,
              backdropEnabled:true,

              header: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width:MediaQuery.of(context).size.width ,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      audioBloc.add(FetchAudio(url: state.url,name: state.name ,img:state.img,showName:state.showName));
                      },
                    child: Text("اعد المحاولة"),

                  ),
                ),
              ),
              panel: Column(

              )



          ),
        );
        }
      }


    );
  }
}
