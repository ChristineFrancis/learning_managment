import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class SendAnswersQuizData {
  ApiPostRequest apiPostRequest;
  SendAnswersQuizData(this.apiPostRequest);

  postAnswers(String url, int? quizId, int quiznum, List answers, String? token) async {
    Map<String, dynamic> data = {
      "quiz_id": quizId,
      "quiz_number": quiznum,
      "answers": answers
    };
    print('Request data: $data');
    var response = await apiPostRequest.postRequest(url, data, token);
    return response.fold(
      (ifLeft) =>ifLeft,
      (ifRight) => ifRight,
    );
  }
}
