class CatwithEpi {
  List<Category>? category;

  CatwithEpi({this.category});

  CatwithEpi.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? caticon;
  String? catname;
  List<Episodes>? episodes;
  int? id;

  Category({this.caticon, this.catname, this.episodes, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    caticon = json['caticon'];
    catname = json['catname'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caticon'] = this.caticon;
    data['catname'] = this.catname;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Episodes {
  String? episodeDescr;
  String? episodeName;
  int? episodeNum;
  String? episodeUrl;
  int? mcategoryId;
  String? showname;
  String? shownameimg;

  Episodes(
      {this.episodeDescr,
        this.episodeName,
        this.episodeNum,
        this.episodeUrl,
        this.mcategoryId,
        this.showname,
        this.shownameimg});

  Episodes.fromJson(Map<String, dynamic> json) {
    episodeDescr = json['episodeDescr'];
    episodeName = json['episodeName'];
    episodeNum = json['episodeNum'];
    episodeUrl = json['episodeUrl'];
    mcategoryId = json['mcategory_id'];
    showname = json['showname'];
    shownameimg = json['shownameimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episodeDescr'] = this.episodeDescr;
    data['episodeName'] = this.episodeName;
    data['episodeNum'] = this.episodeNum;
    data['episodeUrl'] = this.episodeUrl;
    data['mcategory_id'] = this.mcategoryId;
    data['showname'] = this.showname;
    data['shownameimg'] = this.shownameimg;
    return data;
  }
}