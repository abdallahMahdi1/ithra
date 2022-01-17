class Show {
  Show({
    this.mainShow,
  });

  List<MainShow>? mainShow;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    mainShow: List<MainShow>.from(json["main show"].map((x) => MainShow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "main show": List<dynamic>.from(mainShow!.map((x) => x.toJson())),
  };
}

class MainShow {
  MainShow({
    this.categoryId,
    this.description,
    this.id,
    this.showimg,
    this.showname,
  });

  String? categoryId;
  String? description;
  String? id;
  String? showimg;
  String? showname;

  factory MainShow.fromJson(Map<String, dynamic> json) => MainShow(
    categoryId: json["category_id"].toString(),
    description: json["description"],
    id: json["id"].toString(),
    showimg: json["showimg"],
    showname: json["showname"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "description": description,
    "id": id,
    "showimg": showimg,
    "showname": showname,
  };
}
