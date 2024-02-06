String databaseModelsTemplate = '''

class TheAvengersModels{
  int? id;
  String? name;
  String? fullName;
  String? email;
  String? gender;
  String? isCanSwim;
  String? isCanFly;
  int? status; 
  String? createdAt;
  TheAvengersModels({this.id, this.name, this.fullName, this.email, this.gender, this.isCanSwim, isCanFly, this.status, this.createdAt});
  TheAvengersModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    fullName = map['full_name'];
    email = map['email'];
    gender = map['gender'];
    isCanFly = map['is_can_fly'];
    isCanSwim = map['is_can_swim'];
    status = map['status'];
    createdAt = map['created_at'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['full_name'] = fullName;
    map['email'] = email;
    map['gender'] = gender;
    map['is_can_swim'] = isCanSwim;
    map['is_can_fly'] = isCanFly;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }
}
''';