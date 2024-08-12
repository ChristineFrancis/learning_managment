import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_managment_system/core/constant/color.dart';

class TeacherDetails extends StatefulWidget {
  final String image;
  final String name;
  final String email;
  final Widget widget;

  const TeacherDetails({
    super.key,
    required this.name,
    required this.email,
    required this.image, 
    required this.widget,
  });

  @override
  State<TeacherDetails> createState() => _TeacherState(
        name: this.name,
        email: this.email,
        image: this.image,
        widgett:this.widget
      );
}

class _TeacherState extends State<TeacherDetails> with TickerProviderStateMixin {
  final String image;
  final String name;
  final String email;
  final Widget widgett;

  late AnimationController _animationController;
  bool isExpanded = false;

  _TeacherState({required this.widgett, required this.image, required this.name, required this.email});

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: 400.ms,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedContainer(
        height: 85,
        width: isExpanded ? Get.width * 0.9 : 85,
        duration: 400.ms,
        decoration: BoxDecoration(
          color:AppColor.whiteColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey,
              spreadRadius: -8,
              blurRadius: 5,
              offset: Offset(0, 7),
            )
          ],
        ),
        child: Row(
          children: [
            InkWell(//CircleBorder(side: BorderSide(width: 85), ) ,
               borderRadius: BorderRadius.circular(50),
              child: ClipOval(
                child: widgett
                
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  if (isExpanded) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                });
              },
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: isExpanded ? 1 : 0,
                duration: 200.ms,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTeacherDetails(title: 'Name', text: name,),
                            CustomTeacherDetails(title: 'Email', text: email,),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('widget', widget));
  }
}
class CustomTeacherDetails extends StatelessWidget {
  final String title;
  final String text;
  const CustomTeacherDetails({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
                              children: [
                                Text(
                                  '$title: ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(text),
                              ],
                            );
  }
}