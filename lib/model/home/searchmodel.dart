class SearchModel {
  int? id;
  String? name;
  int? categoryId;
  int? teacherId;
  String? description;
  int? totalLikes;
  String? categoryName;
  String? createdFrom;
  String? image;
  List<Videos>? videos;
  Teacher? teacher;

  SearchModel(
      {this.id,
      this.name,
      this.categoryId,
      this.teacherId,
      this.description,
      this.totalLikes,
      this.categoryName,
      this.createdFrom,
      this.image,
      this.videos,
      this.teacher});
  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    teacherId = json['teacher_id'];
    description = json['description'];
    totalLikes = json['total_likes'];
    categoryName = json['category_name'];
    createdFrom = json['created_from'];
    image = json['image'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }
}

class Videos {
  String? name;
  String? description;

  Videos({this.name, this.description});

  Videos.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }
}

class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? createdFrom;
  String? image;

  Teacher(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdFrom,
      this.image});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    createdFrom = json['created_from'];
    image = json['image'];
  }
}
