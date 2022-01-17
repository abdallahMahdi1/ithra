import 'package:http/http.dart' as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'dart:convert';

import 'package:ithra/modules/category_module.dart';


Future<Cat> fetchCata() async {
  String url = urlPath();

  final response = await http.get(Uri.parse('$url/catlist_with_shows'));
  if(response.statusCode == 200)
    {
      final responseBody = json.decode(response.body);
      Cat cat = Cat.fromJson(responseBody);
      return cat;
    }
  else {
    throw "error";
  }
}

