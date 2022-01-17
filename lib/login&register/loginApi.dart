import 'dart:convert';

import 'package:http/http.dart 'as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'package:ithra/login&register/login_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginAndRegister{
  String url = urlPath();
  late var statue;

  getToken({String? email,String? password}) async {
    String? username = email;
    String? pass = password;
    String basicAuth =  'Basic ' +
        base64Encode(utf8.encode('$username:$pass'));
    http.Response response = await http.post(
        Uri.parse(url+'/login'), headers: {"Authorization": basicAuth,});
    statue = response.body.contains("error");
    final jsonResponse = json.decode(response.body);
    LoginAndRegisterModel token = LoginAndRegisterModel.fromJson(jsonResponse);
    if(statue){
      return statue;
    }
    else{
      save(token.token!,email!,token.publicId!);

      return statue;
    }


  }

  save(String token,String email,String publicID)async{
    final perf = await SharedPreferences.getInstance();
    final key = "token";
    final value = token;
    final key2 ="email";
    final value2 = email ;
    perf.setString(key,value);
    perf.setString(key2,value2);
    final key3 = "publicId";
    final value3 = publicID;
    perf.setString(key3,value3);




  }

  Future<String?> getRegister({String? username,String? email,String? password}) async{
    Map data = {
      "name":username,"email":email,"password":password
    };
    String body = json.encode(data);
    http.Response response = await http.post(Uri.parse(url+'/register'),
      headers: {"Content-Type": "application/json"},
      body: body,);
    final jsonResponse = json.decode(response.body);
    LoginAndRegisterModel main = new LoginAndRegisterModel.fromJson(jsonResponse);
    return main.massage;
  }


}