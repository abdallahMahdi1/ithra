import 'package:flutter/material.dart';
import 'package:ithra/api_fetch/info_fetch.dart';
import 'package:ithra/modules/info_module.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("للتواصل معنا"),
        backgroundColor: Colors.black,
        centerTitle: true,),
      body:FutureBuilder<InfoMod>(
        future:fetchInfo(),
        builder:  (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("${snapshot.data!.info![0].info}",textAlign: TextAlign.justify,style: TextStyle(fontSize: 20),),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: Text("Try again"),
                ));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),



    );
  }
}
