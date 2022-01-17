import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/main_bloc.dart';
import 'package:ithra/more_page/what_is_podcast.dart';
import 'package:ithra/pages/cat_page.dart';
import 'blocs/audio_player_bloc.dart';
import 'blocs/cat_with_epi_bloc.dart';
import 'blocs/category_bloc.dart';
import 'blocs/subscriber_bloc.dart';
import 'login&register/login_bloc.dart';
import 'login&register/register_page.dart';
import 'login&register/reigisterBloc.dart';
import 'login&register/login_page.dart';
import 'more_page/info.dart';
import 'pages/home_page.dart';
import 'pages/show_page.dart';
import 'loading.dart';
import 'package:flutter/widgets.dart';

main() => runApp(

    MyApp(), );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>RegisterBloc(UserNotRegistered()),),
        BlocProvider(
          create: (BuildContext context)=>CategoryBloc(AppIsClosed2()),),
        BlocProvider(
          create: (BuildContext context)=>AudioBloc(AudioIsNotSearched()),),
        BlocProvider(
          create: (BuildContext context)=>LoginBloc(UserNotLogined()),),
        BlocProvider(
          create: (BuildContext context)=>CategoryWithEpiBloc(AppIsClosed()),),
        BlocProvider(
          create: (BuildContext context)=>MainShowBloc(MainShowNotLoaded()),),
        BlocProvider(
          create: (BuildContext context)=>SubscriberBloc(AppIsClosed1()),),
      ],
      child:Directionality(textDirection: TextDirection.rtl,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
          fontFamily: "Tajawal",
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/register' :(context) => RegisterPage(),
          '/home':(context) => HomePage(),
          '/login':(context) =>LoginPage(),
           '/ShowPage': (context) => ShowPage(),
          '/podcast':(context) =>PodCast(),
          '/info':(context) =>Info(),
          '/catPage':(context)=>CatPage(),
        },

      ),),
      
    );
  }
}