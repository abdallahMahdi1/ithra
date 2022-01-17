import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithra/login&register/reigisterBloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible =false;


  @override
  Widget build(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context) ;

    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("انشاء حساب جديد",style: TextStyle(fontSize: 20),),
            ),],)),
            SizedBox(height: 20),
            new Theme(
              data: new ThemeData(
                primaryColor: Colors.black,
              ),
              child:new  TextFormField(
                controller:_usernameController ,
                decoration: InputDecoration(
                    labelText: 'اسم المستخدم',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black),
                    ),

                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),


                    prefixIcon: Icon(Icons.person,color: Colors.black,)
                ),

      ),
            ),
            SizedBox(height: 20),
            new Theme(
              data: new ThemeData(
                primaryColor: Colors.black,
              ),
              child: new TextFormField(
                controller:_emailController ,
                decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black),
                    ),

                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(Icons.email,color: Colors.black,)
                ),
              ),
            ),
            SizedBox(height: 20),
            new Theme(
              data: new ThemeData(
                primaryColor: Colors.black,
              ),
              child: new TextFormField(

                obscureText: !_passwordVisible,
                controller:_passwordController ,
                decoration: InputDecoration(
                    labelText: ' كلمة السر <5 ارقام>',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black,),
                    ),


                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
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
            ),
            SizedBox(height: 20),

            BlocBuilder(
              bloc: registerBloc,
              builder: (BuildContext context, dynamic state){
                if (state is UserNotRegistered){
                  return Text(" الرجاء اداخال البيانات كامله");

                }
                else if(state is RegisterIsLoading){
                  return Text("الرجاء الانتظار جاري التسجيل");
                }
                else if(state is RegisterSuccessful){
                  return Text(state.result!);
                }
                else if(state is RegisterFailed){

                  return Text(" الرجاء التاكد من الاتصال بالنترنت ");
                }

                return Text("error");
                },
            ),

        SizedBox(height: 20),

            new OutlinedButton(onPressed: (){
              if (_emailController.text
                  .trim()
                  .toLowerCase()
                  .isNotEmpty &&_passwordController.text
                  .isNotEmpty &&_usernameController.text.trim().isNotEmpty && _passwordController.text.length == 5) {
                registerBloc.add(FetchRegister(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text,
                    email: _emailController.text.trim().toLowerCase()));
              }
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
                child: Text("إنشاء حساب",style: TextStyle(color: Colors.black),),
                style:  OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))

                ),

            )


          ],

        ),
      )

    ));
  }
}
