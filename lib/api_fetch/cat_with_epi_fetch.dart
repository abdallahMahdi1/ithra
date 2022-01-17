import 'package:http/http.dart' as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'dart:convert';

import 'package:ithra/modules/category_with_epi_model.dart';


Future<CatwithEpi> fetchCatawithepi() async {
  String url = urlPath();


  final response = await http.get(Uri.parse('$url/catlist_with_epsoides'));
  if(response.statusCode == 200)
    {
      final responseBody = json.decode(response.body);
      CatwithEpi cat = CatwithEpi.fromJson(responseBody);
      return cat;
    }
  else {
    throw "error";
  }
}