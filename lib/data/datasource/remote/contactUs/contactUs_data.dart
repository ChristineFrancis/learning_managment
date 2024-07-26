import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class ContactUsData {
  ApiPostRequest apiPostRequest;
  ContactUsData(this.apiPostRequest);

  postMessage( String message , String? token) async {
    Map<String, dynamic> data = {
      "description": message
    };
    print('Request data: $data');
    var response = await apiPostRequest.postRequest(AppUrl.contactUs, data , token);
    return response.fold(
      (ifLeft) =>ifLeft,
      (ifRight) => ifRight,
    );
  }
}
