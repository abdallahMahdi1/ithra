import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ithra/blocs/audio_player_bloc.dart';
import 'package:ithra/blocs/category_bloc.dart';
import 'package:ithra/services/Category_widget.dart';
import 'package:ithra/services/audioBar.dart';
import 'package:ithra/services/showWidget.dart';
class CatPage extends StatefulWidget {
  @override
  _CatPageState createState() => _CatPageState();
}
class _CatPageState extends State<CatPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() {
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    _refreshController.refreshCompleted();

  }
  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;
    return Scaffold(
      body:  Stack(
          children: [

        SmartRefresher(
          enablePullDown: true,

          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child:ListView(

              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (BuildContext context, state) {
                      if (state is AppIsClosed2) {
                        return Container();
                      }
                      if(state is CategoryIsLoading)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.8,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.08,
                              height: MediaQuery.of(context).size.height*0.04,
                              child: CircularProgressIndicator(color: Colors.black,),
                            ),
                          ),);
                      }
                      if (state is CategorySuccessful){
                        return ListView.builder(
                            shrinkWrap: true,

                            physics: ScrollPhysics(),
                            itemCount: state.result.category!.length,
                            itemBuilder: (context, indexx) {
                              return
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.335,
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
                                              itemCount: state.result.category![indexx].shows!.length,
                                              itemBuilder: (context, index) {
                                                return ShowWidget(
                                                  showimage: state.result.category![indexx].shows![index].showimg,
                                                  showname: state.result.category![indexx].shows![index].showname,
                                                  showId: state.result.category![indexx].shows![index].id,
                                                  description: state.result.category![indexx].shows![index].description,
                                                );
                                              }))],

                                  ),
                                );
                            });
                      }
                      if(state is CategoryFailed){
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
            ),


        ),
        BB(audioBloc:_audioBloc ,)
          ]
        ),
      );
  }
}
