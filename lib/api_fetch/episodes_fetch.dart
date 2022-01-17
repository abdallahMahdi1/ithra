import 'package:http/http.dart' as http;
import 'package:ithra/api_fetch/url_path.dart';
import 'dart:convert';

import 'package:ithra/modules/episodes_module.dart';


Future<EpisodeList> fetchEpisode(String showId) async {
  String url = urlPath();

  final response =
      await http.get(Uri.parse('$url/episodeslist/' + showId));

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    EpisodeList episode = EpisodeList.fromJson(responseBody);
    return episode;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
