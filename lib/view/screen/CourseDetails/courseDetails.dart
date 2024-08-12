import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/teacherDetails.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/video.dart';
import 'package:learning_managment_system/view/screen/quiz/quizzes_videos.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizVideosControllerImp controller = Get.put(QuizVideosControllerImp());
    //Get.put(QuizVideosControllerImp());
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back , color: AppColor.whiteColor , size: 35,) , 
        onPressed: () {
          Get.back();
        },),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Text(
            "${controller.course?.name ?? ''}",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.w600, color: AppColor.whiteColor),),
        ) ,
      backgroundColor: AppColor.primaryColor,),
      
      body: GetBuilder<QuizVideosControllerImp>(builder: (controller) {
        var courseDetails = controller.course;
        if (courseDetails == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
              fillOverscroll: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //   '${courseDetails.name ?? ''}',
                  //   style: TextStyle(
                  //       color: AppColor.primaryColor,
                  //       fontSize: 45,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  //     Container(height: 150,
                  //       child: Image.network(courseDetails.image!, fit:BoxFit.cover)),
                        
                  //   ],
                 // ),
                //  SizedBox(height:25),
                //   Text(
                //     '${courseDetails.name ?? ''}',
                //     style: TextStyle(
                //         color: AppColor.primaryColor,
                //         fontSize: 45,
                //         fontWeight: FontWeight.w600),
                //   ),
                  SizedBox(height: 25),
                  CustomCourseDetails(title:'Created from' , text:'${courseDetails.createdFrom ?? ''}', iconData: Icons.date_range_outlined ,),
                  SizedBox(height: 15),
                  CustomCourseDetails(title:'Description' , text:'${courseDetails.description ?? ''}', iconData: Icons.description_outlined ,),
                  SizedBox(height: 15),
                  CustomCourseDetails(title:'Total likes' , text:'${courseDetails.totalLikes.toString() ?? ''}', iconData: Icons.favorite_outline ,),
                   SizedBox(height: 15),
                  CustomCourseDetails(title:'Number of videos' , text:'${controller.course!.videos!.length.toString()}', iconData: Icons.video_collection_outlined,),
                  SizedBox(height: 15),
                  CustomCourseDetails(title:'Number of quizzes' , text:'${controller.course!.quizzes!.length.toString()}', iconData: Icons.quiz_outlined,),
                  SizedBox(height: 15),
                  CustomCourseDetails(title:'Price' , text:'${courseDetails.price.toString() ?? ''}', iconData: Icons.attach_money ,),
                  SizedBox(height: 20),
                   Padding(
                    padding:  EdgeInsets.symmetric(horizontal:Get.width/7),
                    child:  Divider(color: AppColor.purple7,thickness: 5,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        //Icon(Icons.person_2_outlined, color: AppColor.primaryColor, size: 32),
                        Text('Teacher:',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600 , color:AppColor.primaryColor )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0 ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100 , vertical: 10),
                          child: Text("Tap to see teacher's details.." , style: TextStyle(
                        color: AppColor.lightGreyColor,
                        fontSize: 20,
                      ),),
                        ),
                        TeacherDetails(
                          name: controller.teacher!.firstName! +
                              " " +
                              controller.teacher!.lastName!,
                          email: controller.teacher!.email!,
                          image: ImageAsset.noProfilePicture,
                          widget: controller.teacher!.image!.isEmpty || controller.teacher!.image==null ? 
                          Image.asset(
                           ImageAsset.noProfilePicture,
                           height: 85,
                           width: 85,
                           fit: BoxFit.cover,)
                           :Image.network(
                           controller.teacher!.image!,
                           height: 85,
                           width: 85,
                           fit: BoxFit.cover,)
                 ,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Get.width/5 , vertical: 10),
                    child:courseDetails.studentHasEnrolled==0?
                     CustomButton(
                      textButton: 'Enroll',
                      onTap: () {controller.enroll(courseDetails.id!);},
                    )
                    : 
                    CustomButton(
                      textButton: 'Unenroll',
                      onTap: () {controller.unEnroll(courseDetails.id!);},
                    )
                    ,
                  ),
                 Center(
                   child: MaterialButton(
                    onPressed: () {print('studentHasEnrolledddddddddddddddddd ${courseDetails.studentHasEnrolled}');
                      if(courseDetails.studentHasEnrolled==1 )
                      { Get.to(QuizVideos());}
                      else
                      {
                         Get.defaultDialog(title:"You can't see the content if you don't enroll" , content: Text('') , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20 ) );

                      }
                     
                    },
                     child: Text(
                        'See the course content',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w500),
                      ),
                   ),
                 ),
                ],
              ),
            ),]
          ),
        );
      }),
    );
  }
}
class CustomCourseDetails extends StatelessWidget {
  final String title;
  final String text;
  final IconData iconData;

  const CustomCourseDetails({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: AppColor.primaryColor,
            size: 30,
          ),
          SizedBox(width:5), 
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
