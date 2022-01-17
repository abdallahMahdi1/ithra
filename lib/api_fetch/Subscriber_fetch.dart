import 'package:http/http.dart' as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'dart:convert';

import 'package:ithra/modules/Subscriber_module.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<Subscriber> fetchSubscriber() async {
  String url = urlPath();

  final perf = await SharedPreferences.getInstance();
    final key3 ="publicId";
    final value =perf.getString(key3);
    final response = await http.get(Uri.parse(
        '$url/user/$value'));
    if (response.statusCode == 200)
      {
        final responseBody = json.decode(response.body);
        Subscriber sub = Subscriber.fromJson(responseBody);
        return sub;
      }
    else {
      throw "error";
    }
  }


