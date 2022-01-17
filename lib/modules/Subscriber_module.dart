class Subscriber {
  List<Users>? users;

  Subscriber({this.users});

  factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
   users: List<Users>.from(json["users"].map((x) => Users.fromJson(x))),
  );

}

class Users {
  String? name;
  List<Subscribers>? subscribers;

  Users({this.name, this.subscribers});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    name: json['name'],
    subscribers: List<Subscribers>.from(json["subscribers"].map((x) => Subscribers.fromJson(x))),
  );

}

class Subscribers {
  String? description;
  String? id;
  String? showimg;
  String? showname;

  Subscribers({this.description, this.id, this.showimg, this.showname});

  factory Subscribers.fromJson(Map<String, dynamic> json) => Subscribers(
    description: json["description"] ,
    id: json["id"].toString(),
    showimg: json["showimg"] ,
    showname: json["showname"],
  );


}