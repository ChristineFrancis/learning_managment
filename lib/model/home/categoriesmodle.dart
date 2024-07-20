
import 'package:learning_managment_system/model/courses/coursemodel.dart';

class Categories {
  final int? id;
  final String? name;
  final Null parentId;
  final String? createdFrom;
  final String? image;
  List<CoursesModel>? courses;
//
  Categories(
      {this.id, this.name, this.parentId, this.createdFrom, this.image, List<CoursesModel>? courses, });

  factory Categories.fromJson(Map<String, dynamic> json) {
  
  //  List<CoursesModel> courseslist =
  //      list.map((course) => CoursesModel.fromJson(course)).toList();
    
    return Categories(
        id: json['id'],
        name: json['name'],
        parentId: json['parent_id'],
        createdFrom: json['created_from'],
        image: json['image'],
        courses:(json['categories']  as List<dynamic>?) ?.map((courseslist) => CoursesModel.fromJson(courseslist))
          .toList(),
        );
  }
}
