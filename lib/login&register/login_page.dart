import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/blocs/subscriber_bloc.dart';

import 'login_bloc.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible =false;


  @override
  Widget build(BuildContext context) {



    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            Card(child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("تسجيل الدخول",style: TextStyle(fontSize: 20),),
            ),],)),
            SizedBox(height: 20),
             TextFormField(

                controller:_emailController ,
                decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
                    labelStyle: TextStyle(color: Colors.black),


                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(

                    ),
                    prefixIcon: Icon(Icons.email,color: Colors.black,)

                ),
              ),
            SizedBox(height: 20),
            TextFormField(

                obscureText: !_passwordVisible,
                controller:_passwordController ,
                decoration: InputDecoration(
                    labelText: ' كلمة السر',
                    labelStyle: TextStyle(color: Colors.black),

                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black),
                    ),

                    border: OutlineInputBorder(
                    ),
                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = true;
                        });
                      },

                      child: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.black,),
                    )
                )
            ),
            SizedBox(height: 20),
            BlocBuilder<LoginBloc,LoginState>(

              builder: (BuildContext context, state){
                if (state is UserNotLogined){
                  return Text(" الرجاء اداخال البيانات كامله");

                }
                else if(state is LoginIsLoading){
                  return Text("الرجاء الانتظار جاري التسجيل");
                }
                else if(state is LoginSuccessful){
                  if (state.result){
                    return Text("البريد او كلمة السر غير صحيحة ");
                  }
                  else{
                    Future.delayed(const Duration(milliseconds: 500),
                            ()async{
                          BlocProvider.of<SubscriberBloc>(context).add(FetchSubscriber());
                          await Navigator.pushReplacementNamed(context, "/home");
                        });
                  }


                }
                else if(state is LoginFailed){

                  return Text(" الرجاء التاكد من الاتصال بالنترنت ");
                }

                return Text("");
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new OutlinedButton(onPressed:() async {
              if (_emailController.text
                  .trim()
                  .toLowerCase()
                  .isNotEmpty && _passwordController.text.isNotEmpty){
              BlocProvider.of<LoginBloc>(context).add(FetchLogin(
              email: _emailController.text.trim().toLowerCase(),
              password: _passwordController.text));}
              else {
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(

                      content: new Text("الرجاء التاكد من ملئ جميع البيانات",style: TextStyle(fontSize: 14),),
                      actions: <Widget>[
                        TextButton(
                          child: Text('اغلاق!'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
              }
              },
                child: Text("تسجيل الدخول",style: TextStyle(color: Colors.black),),
                    style:  OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))

                    ),



                ),
              SizedBox(width: 30),
              new OutlinedButton(onPressed: (){
                Navigator.pushNamed(context, "/register");
              },
                child: Text("انشاء حساب جديد",style: TextStyle(color: Colors.black)),
                style:  OutlinedButton.styleFrom(
                    side: BorderSide( color: Colors.black),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))

                ),
              ),
            ],),


          ],



        ),
      ),

    ));
  }
}

