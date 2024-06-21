class Categories {
 final int? id;
 final  String? name;
 final Null parentId;
 final String? createdFrom;
 final String? image;

  Categories({this.id, this.name, this.parentId, this.createdFrom, this.image});

 factory Categories.fromJson(Map<String, dynamic> json) {
  return Categories( id:json['id'],
    name:json['name'],
    parentId : json['parent_id'],
    createdFrom : json['created_from'],
    image : json['image']);
   
  }
}
