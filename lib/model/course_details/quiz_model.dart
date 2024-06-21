class Course {
  List<Quizzes>? quizzes;

  Course({this.quizzes});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((quiz) => Quizzes.fromJson(quiz))
          .toList(),
    );
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
  int? studentGrade;
  List<Questions>? questions;

  Quizzes(
      {this.id,
      this.courseId,
      this.quizName,
      this.afterVideo,
      this.timer,
      this.createdAt,
      this.updatedAt,
      this.studentGrade,
      this.questions});

  factory Quizzes.fromJson(Map<String, dynamic> json) {
    return Quizzes(
      id: json['id'],
      courseId: json['course_id'],
      quizName: json['quiz_name'],
      afterVideo: json['after_video'],
      timer: json['timer'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      studentGrade: json['student_grade'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((question) => Questions.fromJson(question))
          .toList(),
    );
  }
}

class Questions {
  int? id;
  int? quizId;
  String? questionText;
  int? chosenChoiceId;
  String? createdFrom;
  List<Choices>? choices;

  Questions(
      {this.id,
      this.quizId,
      this.questionText,
      this.chosenChoiceId,
      this.createdFrom,
      this.choices});

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['id'],
      quizId: json['quiz_id'],
      questionText: json['question_text'],
      chosenChoiceId: json['chosen_choice_id'],
      createdFrom: json['created_from'],
      choices: (json['choices'] as List<dynamic>?)
          ?.map((choice) => Choices.fromJson(choice))
          .toList(),
    );
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

  factory Choices.fromJson(Map<String, dynamic> json) {
    return Choices(
      id: json['id'],
      questionId: json['question_id'],
      choiceText: json['choice_text'],
      isCorrect: json['is_correct'],
      createdFrom: json['created_from'],
    );
  }
}
