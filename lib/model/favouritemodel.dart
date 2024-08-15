
import 'dart:ffi';

class FavoriteModel {
  int? id;
  String? name;
  int? categoryId;
  int? teacherId;
  String? description;
  int? totalLikes;
  String? status;
  int? price;
  String? categoryName;
  String? createdFrom;
  String? image;
  Pivot? pivot;
  Teacher? teacher;

  FavoriteModel(
      {this.id,
      this.name,
      this.categoryId,
      this.teacherId,
      this.description,
      this.totalLikes,
      this.status,
      this.price,
      this.categoryName,
      this.createdFrom,
      this.image,
      this.pivot,
      this.teacher});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    teacherId = json['teacher_id'];
    description = json['description'];
    totalLikes = json['total_likes'];
    status = json['status'];
    price = json['price'];
    categoryName = json['category_name'];
    createdFrom = json['created_from'];
    image = json['image'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    teacher =
        json['teacher'] != null ?  Teacher.fromJson(json['teacher']) : null;
  }
}

class Pivot {
  int? userId;
  int? courseId;
  int? isFavorite;
  int? studentHasEnrolled;
  double? progress;

  Pivot(
      {this.userId,
      this.courseId,
      this.isFavorite,
      this.studentHasEnrolled,
      this.progress});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    isFavorite = json['is_favorite'];
    studentHasEnrolled = json['student_has_enrolled'];
    progress = json['progress'].toDouble();
  }
}

class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? status;
  String? createdFrom;
  String? image;

  Teacher(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.status,
      this.createdFrom,
      this.image});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    status = json['status'];
    createdFrom = json['created_from'];
    image = json['image'];
  }
}
