import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/cat_with_epi_bloc.dart';
import 'package:ithra/blocs/main_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/category_bloc.dart';
import 'blocs/subscriber_bloc.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  read() async {
  final perf = await SharedPreferences.getInstance();
  final key = "token";
  final value =  perf.getString(key) ?? "0";
  await Future.delayed(Duration(seconds: 2));

  if (value != "0" ){
  Navigator.pushReplacementNamed(context, "/home");
  }
  else {
    Navigator.pushReplacementNamed(context, "/login");
  }
  }
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    BlocProvider.of<CategoryWithEpiBloc>(context).add(FetchCategoryWithEpi());
    BlocProvider.of<MainShowBloc>(context).add(FetchMainShow());
    BlocProvider.of<SubscriberBloc>(context).add(FetchSubscriber());
    read();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Container(
          child:  Image.asset("images/logo.jpg"),
        )

      ),

    );
  }
}
