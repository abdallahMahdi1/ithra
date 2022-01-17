class Episode {
  final String? episodeId;
  final String? episodeName;
  final String? episodeNum;
  final String? episodeDescr;
  final String? episodeUrl;

  Episode({
    this.episodeName,
    this.episodeNum,
    this.episodeDescr,
    this.episodeUrl,
    this.episodeId,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
      episodeId: json["id"].toString(),
      episodeName: json['episodeName'],
      episodeNum: json['episodeNum'].toString(),
      episodeUrl: json['episodeUrl'],
      episodeDescr: json['episodeDescr']);
}

class EpisodeList {
  final List<Episode>? episodes;
  EpisodeList({this.episodes});

  factory EpisodeList.fromJson(List<dynamic> parsedJson) {
    List<Episode> episodes =  <Episode>[];
    episodes = parsedJson.map((i) => Episode.fromJson(i)).toList();

    return new EpisodeList(episodes: episodes);
  }
}
