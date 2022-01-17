import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/audio_player_bloc.dart';

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({
    Key? key,
    required this.showimage,
    required this.showname,
    required this.episodename,
    required this.episodeUrl,
    required this.episodeDescr
  }) : super(key: key);
  final String? episodeUrl;
  final String? episodename;
  final String? showimage;
  final String? showname;
  final String? episodeDescr;

  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;

    return InkWell(
      onTap: () {
        _audioBloc.add(FetchAudio(url: episodeUrl,name: episodename ,img:showimage,showName:showname));

      },
      child: Container(

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
              child:Image.network(showimage!,
                  fit:BoxFit.fill ,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("images/Default.png",fit: BoxFit.fill,);
                  }
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),

                    )),
                child: Center(child: Text(episodename!,overflow: TextOverflow.clip,style: TextStyle(fontSize: 10),)),
                width: MediaQuery.of(context).size.width * 0.325,
                height: MediaQuery.of(context).size.height * 0.05,

              ),
            ),

          ],
        ),
      ),
    );
  }
}
