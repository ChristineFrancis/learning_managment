


import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class CheckEmailData{

  ApiPostRequest apiPostRequest;
  CheckEmailData(this.apiPostRequest);

  postData(String verificationCode , String url )async
  {
    Map data={
      'verification_code':verificationCode
    };
    var response=await apiPostRequest.postRequest(url,data , null);
    print('Requesttttttttt: $data');

    return response.fold((l) => l, (r) => r);

  }
  resendcode(String? token)async
  {
    // Map<String, String> headers = 
    //    {'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //    };
       var response=await apiPostRequest.postRequest(AppUrl.resendCodeRegister,{}, token);

    return response.fold((l) => l, (r) => r);


  }
}