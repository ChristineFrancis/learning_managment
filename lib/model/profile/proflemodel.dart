// class ProfileModel {
//   Student? student;
//   List<EnrolledCourses>? enrolledCourses;

//   ProfileModel({this.student, this.enrolledCourses});

//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     student = json['student']
//     != null ?  Student.fromJson(json['student']) : null;
//     if (json['enrolled_courses'] != null) {
//       enrolledCourses = <EnrolledCourses>[];
//       json['enrolled_courses'].forEach((v) {
//         enrolledCourses!.add( EnrolledCourses.fromJson(v));
//       });
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_managment_system/services/services.dart';

class Student {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? createdFrom;
  String? image;
  Wallet? wallet;

  Student(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdFrom,
      this.image,
      this.wallet});
 
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      createdFrom: json['created_from'],
      image: json['image'],
      wallet: Wallet.fromJson(json['wallet']),
    );
  }
}

class Wallet {
  int? balance;
  int? points;

  Wallet({this.balance, this.points});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json['balance'],
      points: json['points'],
    );
  }
}

class EnrolledCourses {
  int? id;
  String? name;
  int? categoryId;
  int? teacherId;
  String? description;
  int? totalLikes;
  String? status;
  int? price;
  bool? isFavorite;
  String? categoryName;
  String? createdFrom;
  String? image;

  EnrolledCourses(
      {this.id,
      this.name,
      this.categoryId,
      this.teacherId,
      this.description,
      this.totalLikes,
      this.status,
      this.price,
      this.isFavorite,
      this.categoryName,
      this.createdFrom,
      this.image});

  EnrolledCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    teacherId = json['teacher_id'];
    description = json['description'];
    totalLikes = json['total_likes'];
    status = json['status'];
    price = json['price'];
    isFavorite = json['is_favorite'];
    categoryName = json['category_name'];
    createdFrom = json['created_from'];
    image = json['image'];
  }
}
