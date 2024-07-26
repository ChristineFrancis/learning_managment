import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/functions/checkinternet.dart';


class ApiPostRequest {
  Future<Either<StatusRequest, Map>> postRequestWithImage( String url, Map data, File? imageFile ,String imageKey ,  String? token) async {
        if (await checkInternet()) 
    {
   // final url = Uri.parse(url);
    Map<String,String> headers ={'':''};
      if (token==null)
      {
        headers={ 'Content-Type': 'application/json', };

      }
      else 
      {
        headers= {'Accept': 'application/json',
        'Authorization': 'Bearer $token'
       };
      }
      print('heeeaders upload Photo $headers');
    var request = http.MultipartRequest('POST', Uri.parse(url) );
    request.headers;
    print('requesttttttttttt $request');

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    
    if (imageFile != null) 
    {
      request.files.add(await http.MultipartFile.fromPath(imageKey, imageFile.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
     Map responseBody = jsonDecode(response.body);
    print(response.body);
    return Right(responseBody);
     } 
    else
     {
      return const Left(StatusRequest.offlineFailure);
    }
  }


  Future<Either<StatusRequest, Map>> postRequest(String url, Map data, String? token) async {
    if (await checkInternet()) {
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      };
      print('Headers: $headers');

      var response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      //if (response.statusCode == 200 || response.statusCode == 201 ) {
        Map responseBody = jsonDecode(response.body);
        print('Response from API: $responseBody');
        return Right(responseBody);
      // } else {
      //   print('Error from API: ${response.statusCode}');
      //   return const Left(StatusRequest.serverFailure);
        
      // }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }
}