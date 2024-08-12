import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class EnrollCourseData {
  ApiPostRequest apiPostRequest;
  EnrollCourseData(this.apiPostRequest);

  enroll( int courseId , String? token) async {
    Map<String, dynamic> data = {
      "course_id": courseId
    };
    print('Request data: $data');
    var response = await apiPostRequest.postRequest(AppUrl.quiz, data , token);
    return response.fold(
      (ifLeft) =>ifLeft,
      (ifRight) => ifRight,
    );
  }
}
