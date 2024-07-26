class CoursesModel {
  int? id;
  String? name;
  int? parentId;
  String? createdFrom;
  String? image;
 
  CoursesModel(
      {this.id,
      this.name,
      this.parentId,
      this.createdFrom,
      this.image,
      
      });

  CoursesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    createdFrom = json['created_from'];
    image = json['image'];
   
  }
  
    
  }

