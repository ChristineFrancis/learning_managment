import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_managment_system/controller/profile/postdataprofile.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/profile/profileupdatemodel.dart';
import 'package:learning_managment_system/services/services.dart';

class ProfileUpdteController extends GetxController {
  MyServices myServices = Get.find();
  final http.Client client = http.Client();

  ProfileControllerImp controllerImp = Get.find();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();

  // Variables to store error messages
  var firstNameError = Rx<String?>(null);
  var lastNameError = Rx<String?>(null);
  var emailError = Rx<String?>(null);
  // Flags to indicate if a field has been modified
  var isFirstNameModified = false.obs;
  var isLastNameModified = false.obs;
  var isEmailModified = false.obs;
  var isimageModified = false.obs;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    firstNameError.value = null;
    lastNameError.value = null;
    emailError.value = null;
    super.onInit();
  }

  // Future<void> pickAndUploadImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);
  //   if (pickedFile != null) {
  //     myfile = File(pickedFile.path);
  //     update();
  //     await updatedUser(F, L, E, myfile, imageKey);
  //   }
  // }
  File? myfile;
  Uint8List? image;
  bool hasError = false;
  UpdateStudent? updateStudent;
  updatedUser(firstName, lastName, email, myfile, String? imageKey) async {
    //bool hasError = false;
    print(myfile);
    try {
      Map<String, String> data = {};

      String? token = myServices.sharedPreferences.getString('access_token');
      var request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.updateprofile));
      print('mmmmmm$myfile');

      if (isFirstNameModified.value) {
        if (firstName.isEmpty) {
          firstNameError.value = 'First name cannot be empty';
          hasError = true;
        } else {
          firstNameError.value = null;
          data['first_name'] = firstName;
        }
      }

      if (isLastNameModified.value) {
        // data['last_name'] = lastNameController.text.trim();
        if (lastName.isEmpty) {
          lastNameError.value = 'Last name cannot be empty';
          hasError = true;
        } else {
          lastNameError.value = null;
          data['last_name'] = lastName;
        }
      }
      if (isEmailModified.value) {
        if (email.isEmpty) {
          emailError.value = 'Email cannot be empty';
          hasError = true;
        } else if (!isValidEmail(email)) {
          emailError.value = 'Invalid email format';
          hasError = true;
        } else {
          emailError.value = null;
          data['email'] = email;
        }
      }

      if (data.isEmpty && myfile == null) {
        Get.snackbar('No changes', 'No fields were modified');
        return;
      }

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['_method'] = 'Put';

      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;

      data.forEach((key, value) {
        request.fields[key] = value;
      });

      if (myfile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', myfile.path));

        print('imaggggggggggggg');
        isimageModified.value == true;
        update();
        //controllerImp.fetchProfile();
      }

      // contentType: MediaType('image', basename(imageFile.path)),

      if (hasError) {
        return print('eroooooooooooooooor');
      }
      var response = await request.send();

      print(response.statusCode);
      if (response.statusCode == 200) {
        // Handle successful response
        print('Profile updated successfully');
        Get.snackbar('Success', 'Profile updated successfully');
        //  isimageModified.value = true;
        // controllerImp.fetchProfile();
        // print(request);
        // print(data);
        // print(response);

        //   print( request.fields[key] = value);
        //   print(jsonData);

        update();
        print("cccccccccccccccccccccccccc$myfile");
      } else {
        // Handle error response
        print('Failed to update profile');
        //  Get.snackbar('Error', 'Failed to update profile');
      }
    }
    // catch (e) {
    //   // Handle any exceptions
    //   print('Exception: $e');
    //   Get.snackbar('Error', 'An error occurred while updating profile');
    // }
    finally {
      isFirstNameModified.value = false;
      isLastNameModified.value = false;
      isEmailModified.value = false;
      isimageModified.value = false;
    }
  }

  String? firstName;
  String? lastName;
  String? email;
  String? imageKey;

  galleryorCamera() {
    Get.bottomSheet(
      backgroundColor: AppColor.whiteColor,
      SizedBox(
        width: Get.size.width,
        height: Get.size.height / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Choose:',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () async {
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (xfile == null) return;

                    myfile = File(xfile.path);
                    image = File(xfile.path).readAsBytesSync();
                    update();
                    isimageModified.value == true;
                    print(myfile);
                    // print('vvvvvvv$image');

                    Get.back();

                    print('ppppppppppppppppppppppppppppp$myfile');
                    // updatedUser(firstName, lastName, email, myfile, imageKey);
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.image_outlined,
                          size: 40, color: AppColor.primaryColor),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 18, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (xfile == null) return;

                    myfile = File(xfile.path);
                    image = File(xfile.path).readAsBytesSync();
                    update();
                    // ignore: use_build_context_synchronously
                    Get.back();
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 40, color: AppColor.primaryColor),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 18, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    image = null;
                    update();
                    Get.back();
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.delete_outline,
                          size: 40, color: AppColor.primaryColor),
                      Text(
                        'Remove',
                        style: TextStyle(
                            fontSize: 18, color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  deletProfile() async {
    try {
      final response = await http.delete(Uri.parse(AppUrl.profile), headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // Include token if authentication is required
      });
      if (response.statusCode == 200) {
        // Handle successful response
        print('Profile delete successfully');
      } else {
        // Handle error response
        print('Failed to delete profile');
      }
    } finally {}
  }
  
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$",
  );
  return emailRegex.hasMatch(email);
}
