class UpdateStudent {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? createdFrom;
  String? image;

  UpdateStudent(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.createdFrom,
      this.image});

  UpdateStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    createdFrom = json['created_from'];
    image = json['image'];
  }
}
