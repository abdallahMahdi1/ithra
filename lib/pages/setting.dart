import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/audio_player_bloc.dart';
import 'package:ithra/login&register/loginApi.dart';
import 'package:ithra/login&register/login_bloc.dart';
import 'package:ithra/services/audioBar.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final _audioBloc = BlocProvider.of<AudioBloc>(context) ;

    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      body:Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/podcast");
                  },
                  child: Container(
                      width:MediaQuery.of(context).size.width * 0.85 ,
                      height: MediaQuery.of(context).size.height * 0.05,

                      decoration: BoxDecoration(   borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child:Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(right: 8,left: 8),
                            child: Icon(Icons.info_outline),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text("ما هو البودكاست",style: TextStyle(fontSize: 18),)
                          ),
                          Icon(Icons.arrow_forward),

                        ],
                      )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/info");
                  },
                  child: Center(
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.85 ,
                        height: MediaQuery.of(context).size.height * 0.05,

                        decoration: BoxDecoration(   borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.black,width: 2)
                        ),
                        child:Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8,left: 8),
                              child: Icon(Icons.mic),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text("انضم الي ",style: TextStyle(fontSize: 18),)
                            ),
                            Icon(Icons.arrow_forward),

                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                InkWell(
                  onTap: (){

                      BlocProvider.of<LoginBloc>(context).add(Logout());
                      LoginAndRegister().save("0","0","0");

                      Navigator.pushReplacementNamed(context, "/");

                  },
                  child: Center(
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.85 ,
                        height: MediaQuery.of(context).size.height * 0.05,

                        decoration: BoxDecoration(   borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.red,width: 2)
                        ),
                        child:Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Center(child: Text(" تسجيل الخروج ",style: TextStyle(fontSize: 18,color: Colors.red),))
                            ),
                            Icon(Icons.logout,color: Colors.red,),

                          ],
                        )
                    ),
                  ),
                ),

              ],
            ),
          ),
          BB(audioBloc:_audioBloc)
        ],

      )


    ));
  }
}
