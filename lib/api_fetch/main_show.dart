import 'package:http/http.dart' as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'dart:convert';

import 'package:ithra/modules/Show_module.dart';



Future<Show> fetchMainShows() async {
  String url = urlPath();

  final response =
  await http.get(Uri.parse('$url/showslist/1' ));

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    Show show = Show.fromJson(responseBody);
    return show;

  } else {
    throw Exception('Failed to load album');
  }
}