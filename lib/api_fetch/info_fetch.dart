import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ithra/api_fetch/url_path.dart';
import 'package:ithra/modules/info_module.dart';



Future<InfoMod> fetchInfo() async {
  String url = urlPath();


  final response = await http.get(Uri.parse('$url/info'));
  print(response.body);
  if(response.statusCode == 200) {
    final info = json.decode(response.body);
    InfoMod info1 = InfoMod.fromJson(info);
    return info1;
  }
  else {
    throw "error";
  }
}
