import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/audio_player_bloc.dart';
import 'package:ithra/blocs/cat_with_epi_bloc.dart';
import 'package:ithra/blocs/main_bloc.dart';
import 'package:ithra/services/Category_widget.dart';
import 'package:ithra/services/audioBar.dart';
import 'package:ithra/services/epsiodeWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;
    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      body: Stack(
        children: [
          ListView(

            children: [
              BlocBuilder<MainShowBloc,MainShowState>(
                builder: (BuildContext context ,state){
                  if (state is MainShowNotLoaded){
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width:  MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    );
                  }
                  else if (state is MainShowIsLoading) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.4,
                      color: Colors.grey,
                      );
                  }
                  else if (state is MainShowSuccessful){
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width:  MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/ShowPage', arguments: {
                            "PageName": state.result.mainShow![0].showname,
                            "showId": state.result.mainShow![0].id,
                            "description": state.result.mainShow![0].description,
                            "showimage": state.result.mainShow![0].showimg,
                          });
                        },
                        child: Image.network(state.result.mainShow![0].showimg!,
                            fit:BoxFit.fill ,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset("images/Default.png",fit: BoxFit.fill,);
                          }
                        ),
                      )
                    );
                  }else if (state is MainShowFailed){
                    return  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width:  MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width:  MediaQuery.of(context).size.width * 0.3,
                          color:Colors.white12,
                          child: TextButton(

                            onPressed: (){
                              BlocProvider.of<MainShowBloc>(context).add(FetchMainShow());
                              },
                            child: Text("اعد المحاولة",style: TextStyle(color: Colors.black),),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width:  MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  );
                },
              ),



              Padding(
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<CategoryWithEpiBloc, CategoryWithEpiState>(
                  builder: (BuildContext context, state) {
                    if (state is AppIsClosed) {
                      return Container();
                    }
                    if(state is CategoryWithEpiIsLoading)
                    {
                      return   Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.4,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.08,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: CircularProgressIndicator(color: Colors.black,),
                          ),
                        ),);
                    }
                    if (state is CategoryWithEpiSuccessful){
                      return ListView.builder(
                          shrinkWrap: true,

                          physics: ScrollPhysics(),
                          itemCount: state.result.category!.length,
                          itemBuilder: (context, indexx) {
                            return
                              SizedBox(
                                height:MediaQuery.of(context).size.height * 0.325 ,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    CategoryWidget(
                                      categoryName: state.result.category![indexx].catname,
                                      iconCode: state.result.category![indexx].caticon,
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.result.category![indexx].episodes!.length,
                                            itemBuilder: (context, index) {
                                              return EpisodeWidget(
                                                showimage: state.result.category![indexx].episodes![index].shownameimg,
                                                showname: state.result.category![indexx].episodes![index].showname,
                                                episodename: state.result.category![indexx].episodes![index].episodeName,
                                                episodeUrl: state.result.category![indexx].episodes![index].episodeUrl,
                                                episodeDescr: state.result.category![indexx].episodes![index].episodeDescr,
                                              );
                                            }))],

                                ),
                              );
                          });
                    }
                    if(state is CategoryWithEpiFailed){
                      return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:  MediaQuery.of(context).size.width * 0.3,
                              color:Colors.grey[300],
                             child: TextButton(
                              onPressed: (){
                              BlocProvider.of<CategoryWithEpiBloc>(context).add(FetchCategoryWithEpi());
                              },
                              child: Text("اعد المحاولة",style: TextStyle(color: Colors.black),),
                        ),
                      ),
                          ));
                    }

                    return  Text("");
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.1)
            ],
          ),
          BB(audioBloc:_audioBloc ,)

        ],
      ),

    ));


  }
}
