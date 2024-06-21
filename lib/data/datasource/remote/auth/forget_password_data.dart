


import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class ForgetPasswordData{

  ApiPostRequest apiPostRequest;
  ForgetPasswordData(this.apiPostRequest);

  postData(String email)async
  {
    var response=await apiPostRequest.postRequest(AppUrl.forgetPasswordUrl,
     {
      'email':email
    }, null);
    return response.fold((l) => l, (r) => r);

  }
}