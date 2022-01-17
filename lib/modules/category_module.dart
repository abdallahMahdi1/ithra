class Cat {
  Cat({
    this.category,
  });

  List<Category>? category;

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );


}

class Category {
  Category({
    this.caticon,
    this.catname,
    this.id,
    this.shows,
  });

  String? caticon;
  String? catname;
  String? id;
  List<Show>? shows;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    caticon: json["caticon"],
    catname: json["catname"],
    id: json["id"].toString(),
    shows: List<Show>.from(json["shows"].map((x) => Show.fromJson(x))),
  );


}

class Show {
  Show({
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

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    categoryId: json["category_id"].toString(),
    description: json["description"] ,
    id: json["id"].toString(),
    showimg: json["showimg"] ,
    showname: json["showname"],
  );


}
