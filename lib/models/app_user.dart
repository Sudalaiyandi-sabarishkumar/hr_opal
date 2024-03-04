class AppUser {

  AppUser({this.id, this.firstname, this.lastname});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstname = json['first_name'].toString();
    lastname = json['last_name'].toString();
  }
  int? id;
  String? firstname;
  String? lastname;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
