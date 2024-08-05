class CourseDetailsModel {
  Course? course;

  CourseDetailsModel({this.course});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? name;
  int? categoryId;
  String? categoryName;
  String? description;
  int? totalLikes;
  int? price;
  int? isFavorite;
  int? studentHasEnrolled;
  int? progress;
  String? createdFrom;
  String? image;
  List<Videos>? videos;
  Teacher? teacher;
  List<Quizzes>? quizzes;

  Course(
      {this.id,
      this.name,
      this.categoryId,
      this.categoryName,
      this.description,
      this.totalLikes,
      this.price,
      this.isFavorite,
      this.studentHasEnrolled,
      this.progress,
      this.createdFrom,
      this.image,
      this.videos,
      this.teacher,
      this.quizzes});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    totalLikes = json['total_likes'];
    price = json['price'];
    isFavorite = json['is_favorite'];
    studentHasEnrolled = json['student_has_enrolled'];
    progress = json['progress'];
    createdFrom = json['created_from'];
    image = json['image'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(new Quizzes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['total_likes'] = this.totalLikes;
    data['price'] = this.price;
    data['is_favorite'] = this.isFavorite;
    data['student_has_enrolled'] = this.studentHasEnrolled;
    data['progress'] = this.progress;
    data['created_from'] = this.createdFrom;
    data['image'] = this.image;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.quizzes != null) {
      data['quizzes'] = this.quizzes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? id;
  String? name;
  String? description;

  Videos({this.id, this.name, this.description});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_from'] = this.createdFrom;
    data['image'] = this.image;
    return data;
  }
}

class Quizzes {
  int? id;
  int? courseId;
  String? quizName;
  int? afterVideo;
  int? timer;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

  Quizzes(
      {this.id,
      this.courseId,
      this.quizName,
      this.afterVideo,
      this.timer,
      this.createdAt,
      this.updatedAt,
      this.questions});

  Quizzes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    quizName = json['quiz_name'];
    afterVideo = json['after_video'];
    timer = json['timer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['quiz_name'] = this.quizName;
    data['after_video'] = this.afterVideo;
    data['timer'] = this.timer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? quizId;
  String? questionText;
  String? createdFrom;
  List<Choices>? choices;
  int? chosenChoiceId;

  Questions(
      {this.id,
      this.quizId,
      this.questionText,
      this.createdFrom,
      this.choices,
      this.chosenChoiceId});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    questionText = json['question_text'];
    createdFrom = json['created_from'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    chosenChoiceId = json['chosen_choice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quiz_id'] = this.quizId;
    data['question_text'] = this.questionText;
    data['created_from'] = this.createdFrom;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    data['chosen_choice_id'] = this.chosenChoiceId;
    return data;
  }
}

class Choices {
  int? id;
  int? questionId;
  String? choiceText;
  int? isCorrect;
  String? createdFrom;

  Choices(
      {this.id,
      this.questionId,
      this.choiceText,
      this.isCorrect,
      this.createdFrom});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    choiceText = json['choice_text'];
    isCorrect = json['is_correct'];
    createdFrom = json['created_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['choice_text'] = this.choiceText;
    data['is_correct'] = this.isCorrect;
    data['created_from'] = this.createdFrom;
    return data;
  }
}
